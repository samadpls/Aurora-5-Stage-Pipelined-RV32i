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
    // val branch = Module( new BranchControl)
    val imm =Module( new ImmdValGen1)
    val Jalr = Module( new jalr)
    val alu_cnt =Module( new alu_controler)
    
    //pipline
    val IF=Module(new Inst_fetch)
    val ID= Module(new ID)
    val EX= Module(new EX)
    val Mem_wb=Module(new MEM_WB)

    //hazards
    val Forward_U=Module(new ForwardUnit)
    val HD=Module(new HazardDetection)
    val BL=Module(new BranchLogic)
    val BF=Module(new DecodeBranchForward)
    val SD=Module(new StructuralDetector)
   
    pc.io.addr:=pc.io.pc_4
    inst_mem.io.addr:=pc.io.pc_out(11,2)
    val inst=inst_mem.io.inst

    IF.io.pc_in:=pc.io.pc_out
    IF.io.pc4_in:=pc.io.pc_4
    IF.io.ins_in:=inst

     
    controler.io.opcod:=IF.io.ins_out(6,0)
    reg_file.io.write:=Mem_wb.io.regWrite_out
    reg_file.io.rs1:=IF.io.ins_out(19,15)
    reg_file.io.rs2:=IF.io.ins_out(24,20)

    


    //immediate  aluCtrl_in
    imm.io.instr:=IF.io.ins_out
    imm.io.pc_val:=IF.io.pc_out

      //alu cntrl
    val func3=RegInit(0.U(3.W))
    func3:=IF.io.ins_out(14,12)
    val func7= RegInit(0.U(1.W))
    func7:=IF.io.ins_out(30)



   

    alu_cnt.io.alu_op:=ID.io.aluOp_out
    alu_cnt.io.func3:=func3
    alu_cnt.io.func7:=func7

     
    

    
    SD.io.rs1_sel := IF.io.ins_out(19, 15)
    SD.io.rs2_sel := IF.io.ins_out(24, 20)
    SD.io.MEM_WB_REGRD := Mem_wb.io.rd_out
    SD.io.MEM_WB_regWr := Mem_wb.io.regWrite_out
    
    

    
    // Controlling Operand A for ALU
  when (ID.io.operandAsel_out === "b10".U) {
    alu.io.in1 := ID.io.pc4_out.asSInt
  }.otherwise {
    when(Forward_U.io.forward_a === "b00".U) {
    alu.io.in1  := ID.io.operandA_out
    } .elsewhen(Forward_U.io.forward_a === "b01".U) {
    alu.io.in1  := EX.io.aluOutput_out
    } .elsewhen(Forward_U.io.forward_a === "b10".U) {
    alu.io.in1 := reg_file.io.WriteData
    } .otherwise {
    alu.io.in1  := ID.io.operandA_out
    }}

    
    //Operand B alu.io.alu_Op:=ID.io.aluCtrl_out
	when(controler.io.extend_sel === "b00".U){
		ID.io.imm  := imm.io.i_imm
	}.elsewhen(controler.io.extend_sel === "b01".U){
		ID.io.imm  := imm.io.u_imm
	}.elsewhen(controler.io.extend_sel === "b10".U){
		ID.io.imm  := imm.io.s_imm
	}.otherwise{
		ID.io.imm  := 0.S
        }
    

    
// *********** ----------- DECODE (ID) STAGE ----------- ********* //
    when(HD.io.ctrl_forward === "b1".U) {
        ID.io.memWrite_in := 0.U
        ID.io.memRead_in := 0.U
        ID.io.br_en_in := 0.U
        ID.io.regWrite_in := 0.U
        ID.io.memToReg_in := 0.U
        ID.io.aluOp_in := 0.U
        ID.io.operandAsel_in := 0.U
        ID.io.operandBsel_in := 0.U
        ID.io.NextPc := 0.U

} .otherwise {
    ID.io.memWrite_in :=controler.io.memwrite.asUInt
    ID.io.memRead_in :=controler.io.memread.asUInt
    ID.io.br_en_in  :=controler.io.branch.asUInt
    ID.io.regWrite_in :=controler.io.regwrite.asUInt
    ID.io.memToReg_in := controler.io.memtoreg.asUInt
    ID.io.aluOp_in:=controler.io.aluop
    ID.io.operandAsel_in := controler.io.op_a
    ID.io.operandBsel_in := controler.io.op_b.asUInt
    ID.io.NextPc :=  controler.io.next_pc

}

    
     //BF
    // Initializing Branch Forward Unit
    BF.io.ID_EX_REGRD := ID.io.rd_out
    BF.io.ID_EX_MEMRD := ID.io.memRead_out
    BF.io.EX_MEM_REGRD := EX.io.rd_out
    BF.io.MEM_WB_REGRD := Mem_wb.io.rd_out
    BF.io.EX_MEM_MEMRD := EX.io.memRead_out
    BF.io.MEM_WB_MEMRD := Mem_wb.io.MemRead_out
    BF.io.rs1_sel := IF.io.ins_out(19, 15)
    BF.io.rs2_sel := IF.io.ins_out(24, 20)
    BF.io.ctrl_branch := controler.io.branch.asUInt

      //branchlogic
    BL.io.in_rs1 := reg_file.io.rs1.asSInt
    BL.io.in_rs2 := reg_file.io.rs2.asSInt
    BL.io.in_func3 := IF.io.ins_out(14,12)


when(BF.io.forward_rs1 === "b0000".U) {
  // No hazard just use register file data
  BL.io.in_rs1 := reg_file.io.rd1
  Jalr.io.addr := reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b0001".U) {
  // hazard in alu stage forward data from alu output
  BL.io.in_rs1 := alu.io.out
  Jalr.io.addr:= reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b0010".U) {
  // hazard in EX/MEM stage forward data from EX/MEM.alu_output
  BL.io.in_rs1 := EX.io.aluOutput_out
  Jalr.io.addr := reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b0011".U) {
  // hazard in MEM/WB stage forward data from register file write data which will have correct data from the MEM/WB mux
  BL.io.in_rs1 := reg_file.io.WriteData
  Jalr.io.addr := reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b0100".U) {
  // hazard in EX/MEM stage and load type instruction so forwarding from data memory data output instead of EX/MEM.alu_output
  BL.io.in_rs1 := data_mem.io.out
  Jalr.io.addr := reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b0101".U) {
  // hazard in MEM/WB stage and load type instruction so forwarding from register file write data which will have the correct output from the mux
  BL.io.in_rs1:= reg_file.io.WriteData
  Jalr.io.addr := reg_file.io.rd1
}.elsewhen(BF.io.forward_rs1 === "b0110".U) {
    // hazard in alu stage forward data from alu output
    Jalr.io.addr := alu.io.out
    BL.io.in_rs1 := reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b0111".U) {
    // hazard in EX/MEM stage forward data from EX/MEM.alu_output
    Jalr.io.addr := EX.io.aluOutput_out
    BL.io.in_rs1 := reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b1000".U) {
    // hazard in MEM/WB stage forward data from register file write data which will have correct data from the MEM/WB mux
    Jalr.io.addr := reg_file.io.WriteData
    BL.io.in_rs1:= reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b1001".U) {
    // hazard in EX/MEM stage and load type instruction so forwarding from data memory data output instead of EX/MEM.alu_output
    Jalr.io.addr := data_mem.io.out
    BL.io.in_rs1 := reg_file.io.rd1
} .elsewhen(BF.io.forward_rs1 === "b1010".U) {
    // hazard in MEM/WB stage and load type instruction so forwarding from register file write data which will have the correct output from the mux
    Jalr.io.addr := reg_file.io.WriteData
    BL.io.in_rs1 := reg_file.io.rd1}
  .otherwise {
    BL.io.in_rs1 := reg_file.io.rd1
    Jalr.io.addr := reg_file.io.rd1
}
// FOR REGISTER RS2 in BRANCH LOGIC UNIT
when(BF.io.forward_rs2 === "b000".U) {
  // No hazard just use register file data
  BL.io.in_rs2  := reg_file.io.rd2
} .elsewhen(BF.io.forward_rs2 === "b001".U) {
  // hazard in alu stage forward data from alu output
  BL.io.in_rs2  := alu.io.out
} .elsewhen(BF.io.forward_rs2 === "b010".U) {
  // hazard in EX/MEM stage forward data from EX/MEM.alu_output
  BL.io.in_rs2  := EX.io.aluOutput_out
} .elsewhen(BF.io.forward_rs2 === "b011".U) {
  // hazard in MEM/WB stage forward data from register file write data which will have correct data from the MEM/WB mux
  BL.io.in_rs2  := reg_file.io.WriteData
} .elsewhen(BF.io.forward_rs2 === "b100".U) {
  // hazard in EX/MEM stage and load type instruction so forwarding from data memory data output instead of EX/MEM.alu_output
  BL.io.in_rs2 := data_mem.io.out
} .elsewhen(BF.io.forward_rs2 === "b101".U) {
  // hazard in MEM/WB stage and load type instruction so forwarding from register file write data which will have the correct output from the mux
  BL.io.in_rs2  := reg_file.io.WriteData
}
  .otherwise {
    BL.io.in_rs2  := reg_file.io.rd2
  }

   
  
   
    
   

     // //jal r
    Jalr.io.addr:=reg_file.io.rd1 //input a
    Jalr.io.pc_addr:= imm.io.i_imm //input b

     
    //ID

    ID.io.memWrite_in:=controler.io.memwrite
    ID.io.memRead_in:=controler.io.memread
    ID.io.memToReg_in:=controler.io.memtoreg
    ID.io.regWrite_in:=controler.io.regwrite.asUInt
    ID.io.operandA_in:=reg_file.io.rd1
    ID.io.operandB_in:=reg_file.io.rd2

    ID.io.operandAsel_in:=controler.io.op_a
    ID.io.operandBsel_in:=controler.io.op_b
	ID.io.aluOp_in := controler.io.aluop
	ID.io.br_en_in := controler.io.branch
	ID.io.NextPc := controler.io.next_pc

    ID.io.pc_in:=IF.io.pc_out
    ID.io.pc4_in:=IF.io.pc4_out
    ID.io.rs1Ins_in:=IF.io.ins_out(19,15)
    ID.io.rs2Ins_in:=IF.io.ins_out(24,20)
    ID.io.rd_in:=IF.io.ins_out(11,7)
    ID.io.operandA_in := reg_file.io.rd1
	ID.io.operandB_in:= reg_file.io.rd2

    // FOR RS1
    when(SD.io.fwd_rs1 === 1.U) {
    ID.io.rs1Ins_in := reg_file.io.WriteData.asUInt
    } .otherwise {
    ID.io.rs1Ins_in := reg_file.io.rd1.asUInt
    }
    // FOR RS2
    when(SD.io.fwd_rs2 === 1.U) {
    ID.io.rs2Ins_in := reg_file.io.WriteData.asUInt
    } .otherwise {
    ID.io.rs2Ins_in := reg_file.io.rd2.asUInt
    }


    when(HD.io.pc_forward === "b1".U) {
    pc.io.addr := HD.io.pc_out.asUInt
    }.otherwise {
    when(controler.io.next_pc === "b01".U) {
      when(BL.io.output === 1.U && controler.io.branch === 1.B) {
        pc.io.addr := imm.io.sb_imm.asUInt
        IF.io.pc_in := 0.U
        IF.io.pc4_in := 0.U
        IF.io.ins_in := 0.U
      }.otherwise {
        pc.io.addr := pc.io.pc_4
      }

    }.elsewhen(controler.io.next_pc === "b10".U) {
      pc.io.addr := imm.io.uj_imm.asUInt
      IF.io.pc_in := 0.U
      IF.io.pc4_in := 0.U
      IF.io.ins_in := 0.U
    } .elsewhen(controler.io.next_pc === "b11".U) {
      pc.io.addr := Jalr.io.out.asUInt
      IF.io.pc_in := 0.U
      IF.io.pc4_in := 0.U
      IF.io.ins_in := 0.U

    }.otherwise {
      pc.io.addr := pc.io.pc_4
    }
    }

    

    when(HD.io.inst_forward === "b1".U) {
    IF.io.ins_in := HD.io.inst_out.asUInt
    IF.io.pc_in := HD.io.current_pc_out.asUInt
    }.elsewhen(controler.io.next_pc  === "b10".U) {
      pc.io.addr := imm.io.uj_imm.asUInt
      IF.io.pc_in := 0.U
      IF.io.pc4_in := 0.U
      IF.io.ins_in := 0.U
     }.otherwise {
        IF.io.ins_in := inst_mem.io.inst
    }
    
  

    
     alu.io.in2:=0.S
    when(ID.io.operandBsel_out===1.U){
        alu.io.in2:=ID.io.imm_out	
    when(Forward_U.io.forward_b==="b00".U){
        EX.io.rs2Sel_in:=ID.io.rs2Ins_out
    }.elsewhen(Forward_U.io.forward_b==="b01".U){
        EX.io.rs2Sel_in:=EX.io.aluOutput_out.asUInt
    }.elsewhen(Forward_U.io.forward_b==="b10".U){
        EX.io.rs2Sel_in:=reg_file.io.WriteData.asUInt
    }
    }.otherwise{
    when(Forward_U.io.forward_b === "b00".U) {
    alu.io.in2 := ID.io.operandB_out
    EX.io.rs2Sel_in := ID.io.operandB_out.asUInt
  } .elsewhen(Forward_U.io.forward_b === "b01".U) {
    alu.io.in2 :=EX.io.aluOutput_out
   EX.io.rs2Sel_in :=EX.io.aluOutput_out.asUInt
  }.elsewhen(Forward_U.io.forward_b === "b10".U) {
    alu.io.in2 := reg_file.io.WriteData
    EX.io.rs2Sel_in := reg_file.io.WriteData.asUInt
  }.otherwise {
    alu.io.in2 := ID.io.operandB_out
    EX.io.rs2Sel_in := ID.io.operandB_out.asUInt

    }}
   alu.io.alu_Op:=alu_cnt.io.x

   
   

    //IF
    
    io.addr:=inst_mem.io.inst

    //HD
    HD.io.IF_ID_INST := IF.io.ins_out
    HD.io.ID_EX_MEMREAD := ID.io.memRead_out
    HD.io.ID_EX_REGRD := ID.io.rd_out
    HD.io.pc_in := IF.io.pc4_out.asSInt
    HD.io.current_pc := IF.io.pc_out.asSInt


    
    

    

    // Operand A
	// when(controler.io.op_a === "b01".U  ){
	// 	ID.io.operandA_in := (IF.io.pc_out).asSInt
	// }.elsewhen(controler.io.op_a === "b10".U){
	// 	ID.io.operandA_in := (IF.io.pc4_out).asSInt 
	// }.otherwise{
	// 	ID.io.operandA_in := reg_file.io.rd1
	// }	
    //branch.io.arg_x:=ID.io.operandA_out
	
    //EX
   

    EX.io.aluOutput_in:=alu.io.out 
    EX.io.rd_in:=ID.io.rd_out // using for 5 cycle delay
    EX.io.rs2Sel_in:=ID.io.rs2Ins_out
    EX.io.memWrite_in:=ID.io.memWrite_out
    EX.io.memRead_in:=ID.io.memRead_out
    EX.io.memToReg_in:=ID.io.memToReg_out
	EX.io.regWrite_in :=ID.io.regWrite_out
	EX.io.baseReg_in := ID.io.operandA_out
	EX.io.offSet_in := ID.io.operandB_out

    Forward_U.io.EX_MEM_REGRD:=EX.io.rd_out
    Forward_U.io.MEM_WB_REGRD:=Mem_wb.io.rd_out
    Forward_U.io.ID_EX_REGRS1:=ID.io.rs1Ins_out
    Forward_U.io.ID_EX_REGRS2:=ID.io.rs2Ins_out
    Forward_U.io.EX_MEM_REGWR:=EX.io.regWrite_out
    Forward_U.io.MEM_WB_REGWR:=Mem_wb.io.regWrite_out
    
    

    //MEM Storage
    
    Mem_wb.io.regWrite_in:=EX.io.regWrite_out
    
    Mem_wb.io.baseReg_in:=EX.io.baseReg_out
    Mem_wb.io.offSet_in:=EX.io.offSet_out
    Mem_wb.io.rs2Sel_in:=EX.io.rs2Sel_out

    
    
  
  
    // //branch     
    // branch.io.arg_x:= 0.S 
    // branch.io.arg_y:= 0.S
    // branch.io.branch := controler.io.branch  


    // branch.io.arg_y:=ID.io.operandB_out
    // branch.io.alu_opp:=controler.io.aluop
   
    // //mux chota wala
    // val mux_b=Mux(branch.io.br_taken,pc.io.pc_4,imm.io.sb_imm.asUInt)
    
    // //mux bara wala
    // val mux_d= MuxLookup (controler.io.next_pc, false .B, Array (
    //             ("b00". U) -> pc.io.pc_4 ,
    //            ("b01".U)-> mux_b,
    //             ("b10".U) -> imm.io.uj_imm.asUInt,
    //             ("b11".U) -> Jalr.io.out.asUInt)
    //          )
  
    


    
//    pc.io.addr:= MuxCase(0.U,Array(
// 		(controler.io.next_pc === 0.U) -> pc.io.pc_4,
// 		// (controler.io.next_pc === 1.U) ->  Mux(Branch.io.br_taken,(ImmediateGeneration.io.sb_imm).asUInt,Pc.io.pc4),
// 		(controler.io.next_pc === 2.U) -> (imm.io.uj_imm).asUInt,
// 		(controler.io.next_pc === 3.U) -> (Jalr.io.out).asUInt
// 	)) 

    data_mem.io.Addr:=EX.io.aluOutput_out(11,2).asUInt
    data_mem.io.MemWrite:=EX.io.memWrite_out
    data_mem.io.MemRead:=EX.io.memRead_out
    data_mem.io.Data:=EX.io.rs2Sel_out.asSInt

    Mem_wb.io.MemRead_in:=EX.io.memRead_out
    Mem_wb.io.memToReg_in:=EX.io.memToReg_out
    Mem_wb.io.memWrite_in:=EX.io.memWrite_out
    Mem_wb.io.dataOut_in:=data_mem.io.out
    Mem_wb.io.aluOutput_in:=EX.io.aluOutput_out
    Mem_wb.io.rd_in:=EX.io.rd_out

    reg_file.io.WriteData:=MuxCase(0.S,Array(
        (Mem_wb.io.memToReg_out === 0.U) -> Mem_wb.io.aluOutput_out,
        (Mem_wb.io.memToReg_out === 1.U) -> Mem_wb.io.dataOut_out
    ))
    reg_file.io.rd:=Mem_wb.io.rd_out
    reg_file.io.write:=Mem_wb.io.regWrite_out

    
}


