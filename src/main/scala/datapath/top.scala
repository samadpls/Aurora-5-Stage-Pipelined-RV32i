package datapath

import chisel3._
import chisel3.util._

class top_io extends Bundle {
    val out=Output(UInt(32.W))
    val addr=Output(UInt(10.W))
}

class Top extends Module{
    val io = IO (new top_io())

    io.out:=0.B

    val pc=Module( new pccounter )
    val data_mem=Module(new datamem)
    val inst_mem =Module(new InstMem)
    val reg_file=Module(new reg)
    val controler = Module( new controler)
    val alu =Module( new ALU4)
    val branch = Module( new BranchControl)
    val imm =Module( new ImmdValGen1)
    val Jalr = Module( new jalr)
    val alu_cnt =Module( new alu_controler)
    
    //pipline
    val IF=Module(new Inst_fetch)
    val ID= Module(new ID)
    val EX= Module(new EX)
    val Mem_wb=Module(new MEM_WB)

    //IF
    inst_mem.io.addr:=pc.io.pc_out(11,2)
    io.addr:=inst_mem.io.addr

    IF.io.pc_in:=pc.io.pc_out
    IF.io.pc4_in:=pc.io.pc_4
    IF.io.ins_in:=inst_mem.io.inst
    pc.io.addr:=pc.io.pc_4
    reg_file.io.rs1:=IF.io.ins_out(19,15)
    reg_file.io.rs2:=IF.io.ins_out(24,20)

    //ID
    controler.io.opcod:=IF.io.ins_out(6,0)
    ID.io.pc_in:=IF.io.pc_out
    ID.io.pc4_in:=IF.io.pc4_out
    ID.io.rd_in:=IF.io.ins_out(11,7)
    ID.io.rs1Ins_in:=IF.io.ins_out(19,15)
    ID.io.rs2Ins_in:=IF.io.ins_out(24,20)

    //alu cntrl
    alu_cnt.io.alu_op:=controler.io.aluop
    val func3=RegInit(0.U(3.W))
    func3:=IF.io.ins_out(14,12)
    val func7= RegInit(0.U(1.W))
    func7:=IF.io.ins_out(30)
    

    
   

    imm.io.instr:=IF.io.ins_out
    imm.io.pc_val:=IF.io.pc_out


    ID.io.memWrite_in:=controler.io.memwrite
    ID.io.memRead_in:=controler.io.memread
    ID.io.memToReg_in:=controler.io.memtoreg
    branch.io.branch:=controler.io.branch
    ID.io.regWrite_in:=controler.io.regwrite.asUInt
    ID.io.operandA_in:=controler.io.op_a.asSInt
    ID.io.operandB_in:=controler.io.op_b.asSInt


    ID.io.aluCtrl_in:=alu_cnt.io.x
    ID.io.operandAsel_in:=reg_file.io.rd1.asUInt
    ID.io.operandBsel_in:=reg_file.io.rd2.asUInt
    

    // register file
    reg_file.io.write:=Mem_wb.io.regWrite_out
    reg_file.io.rd:=Mem_wb.io.rd_out
    reg_file.io.rs1:=ID.io.rs1Ins_out
    reg_file.io.rs2:=ID.io.rs2Ins_out
    //reg_file.io.rd:=ID.io.rd_out

     
    //immediate 
    imm.io.instr:=IF.io.ins_out
    imm.io.pc_val:=IF.io.pc_out

    alu.io.in1:= MuxCase ( 0.S, Array (
                (ID.io.operandA_out.asUInt=== "b00". U ||ID.io.operandA_out.asUInt=== "b11". U) -> reg_file.io.rd1 , //reg aleardy exist in rd1 so need to add
                (ID.io.operandA_out.asUInt=== "b01". U) -> ID.io.pc4_out.asSInt,
                (ID.io.operandA_out.asUInt=== "b10". U) -> ID.io.pc_out.asSInt )
             )

    //imm
    val mux_imm= MuxLookup (controler.io.extend_sel, 0.S, Array (
                ("b00".U) -> imm.io.i_imm ,
                ("b01".U) -> imm.io.s_imm ,
                ("b10".U) -> imm.io.u_imm ,
                ("b11".U) -> reg_file.io.rd2)
             )    
    //data ka d wala mux         
    val mux2_alu= Mux (controler.io.op_b , mux_imm, reg_file.io.rd2 ) 
    val immreg=RegInit(0.S(32.W))

    //EX
    alu.io.in1:=ID.io.rs1Ins_out.asSInt
    when(ID.io.operandBsel_out === "b1".U) {
    alu.io.in2 := immreg
    } .otherwise {
    alu.io.in2 := ID.io.rs2Ins_out.asSInt
    }
    
    alu.io.alu_Op:=ID.io.aluCtrl_out
    alu_cnt.io.func3:=func3
    alu_cnt.io.func7:=func7

    EX.io.aluOutput_in:=alu.io.out 
    EX.io.rd_in:=ID.io.rd_out // using for 5 cycle delay
    EX.io.rs2Sel_in:=ID.io.rs2Ins_out
    EX.io.memWrite_in:=ID.io.memWrite_out
    EX.io.memRead_in:=ID.io.memRead_out
    EX.io.memToReg_in:=ID.io.memToReg_out
	EX.io.regWrite_in :=ID.io.regWrite_out
	EX.io.baseReg_in := ID.io.operandA_out
	EX.io.offSet_in := ID.io.operandB_out
    
    //MEM Storage
    Mem_wb.io.aluOutput_in:=EX.io.aluOutput_out
    Mem_wb.io.dataOut_in:=data_mem.io.out
    Mem_wb.io.rd_in:=EX.io.rd_out
    Mem_wb.io.regWrite_in:=EX.io.regWrite_out
    Mem_wb.io.MemRead_in:=EX.io.memRead_out
    Mem_wb.io.memToReg_in:=EX.io.memToReg_out
    Mem_wb.io.memWrite_in:=EX.io.memWrite_out
    Mem_wb.io.baseReg_in:=EX.io.baseReg_out
    Mem_wb.io.offSet_in:=EX.io.offSet_out
    Mem_wb.io.rs2Sel_in:=EX.io.rs2Sel_out
    
    when(controler.io.next_pc === "b11".U){
		pc.io.addr := Jalr.io.out.asUInt
		IF.io.ins_in := 0.U
		IF.io.pc_in := 0.U
		IF.io.pc4_in := 0.U
	}.elsewhen(controler.io.next_pc === "b10".U){
		pc.io.addr := imm.io.uj_imm.asUInt
		IF.io.ins_in := 0.U
		IF.io.pc_in := 0.U
		IF.io.pc4_in := 0.U
	}
    
    //branch     
    branch.io.arg_x:= 0.S 
    branch.io.arg_y:= 0.S
    branch.io.branch := controler.io.branch  

    // Operand A
	when(controler.io.op_a === "b01".U){
		ID.io.operandA_in := (IF.io.pc_out).asSInt
	}.elsewhen(controler.io.op_a === "b10".U){
		ID.io.operandA_in := (IF.io.pc4_out).asSInt 
	}.otherwise{
		ID.io.operandA_in := reg_file.io.rd1
	}	
    branch.io.arg_x:=ID.io.operandA_out
	//Operand B
	when(controler.io.extend_sel === "b00".U & controler.io.op_b === 1.U){
		ID.io.operandB_in := imm.io.i_imm
	}.elsewhen(controler.io.extend_sel === "b01".U & controler.io.op_b === 1.U){
		ID.io.operandB_in := imm.io.u_imm
	}.elsewhen(controler.io.extend_sel === "b10".U & controler.io.op_b === 1.U){
		ID.io.operandB_in := imm.io.s_imm
	}.otherwise{
		ID.io.operandB_in := reg_file.io.rd2
	}
    branch.io.arg_y:=ID.io.operandB_out
    branch.io.alu_opp:=controler.io.aluop
    //jal r
    Jalr.io.pc_addr:= imm.io.i_imm
    Jalr.io.addr:=reg_file.io.rd1

    //mux chota wala
    val mux_b=Mux(branch.io.br_taken,pc.io.pc_4,imm.io.sb_imm.asUInt)
    
    //mux bara wala
    val mux_d= MuxLookup (controler.io.next_pc, false .B, Array (
                ("b00". U) -> pc.io.pc_4 ,
               ("b01".U)-> mux_b,
                ("b10".U) -> imm.io.uj_imm.asUInt,
                ("b11".U) -> Jalr.io.out.asUInt)
             )
    pc.io.addr:=mux_d


    data_mem.io.Addr:=EX.io.aluOutput_out(11,2).asUInt
    data_mem.io.MemWrite:=EX.io.memWrite_out
    data_mem.io.MemRead:=EX.io.memRead_out
    data_mem.io.Data:=EX.io.rs2Sel_out.asSInt

    reg_file.io.WriteData:=Mem_wb.io.rs2Sel_out.asSInt
}

    

