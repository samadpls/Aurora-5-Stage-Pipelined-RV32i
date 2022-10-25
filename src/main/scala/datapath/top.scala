package controler
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

    pc.io.addr := pc.io.pc_4

    inst_mem.io.addr:=pc.io.pc_out(11,2)
    io.addr:=inst_mem.io.addr

    //controler
    controler.io.opcod:=inst_mem.io.inst(6,0)
    
    // register file
    reg_file.io.write :=controler.io.regwrite
    reg_file.io.rs1:=inst_mem.io.inst(19,15)
    reg_file.io.rs2:=inst_mem.io.inst(24,20)
    reg_file.io.rd:=inst_mem.io.inst(11,7)
    
    
    // immediate 
    imm.io.instr:=inst_mem.io.inst
    imm.io.pc_val:=pc.io.pc_out
    
    
    //alu cntrl
    alu_cnt.io.alu_op:=controler.io.aluop
    alu.io.alu_Op:=alu_cnt.io.alu_op
    alu_cnt.io.func3:=inst_mem.io.inst(14,12)
    alu_cnt.io.func7:=inst_mem.io.inst(30)

    alu.io.in1:= MuxCase ( 0.S, Array (
                (controler.io.op_a=== "b00". U ||controler.io.op_a=== "b11". U) -> reg_file.io.rd1 ,
                (controler.io.op_a=== "b01". U) -> pc.io.pc_4.asSInt,
                (controler.io.op_a=== "b10". U) -> pc.io.pc_out.asSInt )
             )
     //imm '
    
    val mux_imm= MuxLookup (controler.io.extend_sel, 0.S, Array (
                ("b00".U) -> imm.io.i_imm ,
                ("b01".U) -> imm.io.s_imm ,
                ("b10".U) -> imm.io.u_imm ,
                ("b11".U) -> reg_file.io.rd2)
             )
    //data ka d wala mux         
    val mux2_alu= Mux (controler.io.op_b , mux_imm, reg_file.io.rd2 ) 
    alu.io.alu_Op:=alu_cnt.io.x
    alu.io.in2:=mux2_alu
    //branch     //alu
    branch.io.arg_x:= 0.S
    branch.io.arg_y:= 0.S
    branch.io.branch := controler.io.branch
   
    
    when(branch.io.branch===1.B ){
        branch.io.arg_x:=MuxLookup(controler.io.op_a,0.S,Array (
                ("b00".U) -> reg_file.io.rd1,
                ("b01".U) ->pc.io.pc_4.asSInt,
                ("b10".U) -> pc.io.pc_out.asSInt ,
                ("b11".U) -> reg_file.io.rd1)
             )
        // branch.io.alu_opp:=alu_cnt.io.x
        // branch.io.arg_x:= reg_file.io.rd1
        // branch.io.arg_y:= reg_file.io.rd2
        
    }
    when (controler.io.op_b===1.B){
    when (controler.io.extend_sel==="b00".U  ){
    branch.io.arg_y:=imm.io.i_imm
    }.elsewhen(controler.io.extend_sel==="b01".U ){
        branch.io.arg_y:=imm.io.s_imm
    }.elsewhen(controler.io.extend_sel==="b10".U){
        branch.io.arg_y:=imm.io.u_imm
    }.otherwise{ branch.io.arg_y:=reg_file.io.rd2}
    }
  
    branch.io.alu_opp:=controler.io.aluop
        



    //and gate
    // val andd=controler.io.branch & branch.io.br_taken
    
    
   

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

     //data mem
    data_mem.io.Addr:=alu.io.out(9,2)
    data_mem.io.Data:=reg_file.io.rd2
    data_mem.io.MemWrite:=controler.io.memwrite
    data_mem.io.MemRead:=controler.io.memread

    //data mux
    val data_mux= Mux(controler.io.memtoreg,data_mem.io.out,alu.io.out)
    reg_file.io.WriteData:=data_mux

}

    

