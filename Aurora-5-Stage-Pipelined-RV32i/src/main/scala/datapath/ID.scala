package datapath
import chisel3._ 
import chisel3.util._

class ID extends Module{

	val io = IO(new Bundle{


		val memWrite_in = Input(UInt(1.W))
		val memRead_in = Input(UInt(1.W))
		val memToReg_in = Input(UInt(1.W))
		val operandAsel_in = Input(UInt(2.W))
		val operandBsel_in = Input(UInt(1.W))
        val br_en_in = Input(UInt(1.W))
		val aluOp_in = Input(UInt(3.W))
		val regWrite_in = Input(UInt(1.W))
		val operandA_in = Input(SInt(32.W))
		val operandB_in = Input(SInt(32.W))
		val rd_in = Input(UInt(5.W))
		val func3=Input(UInt(3.W))
		val func7=Input(UInt(7.W))
		// val strData_in = Input(SInt(32.W))  
		val rs1Ins_in = Input(UInt(5.W))
		val rs2Ins_in = Input(UInt(5.W))
		
		val pc_in = Input(UInt(32.W))
		val pc4_in = Input(UInt(32.W))

		val NextPc =Input(UInt(2.W))
		val imm =Input(SInt(32.W))

		val memWrite_out = Output(UInt(1.W))
		val memRead_out = Output(UInt(1.W))
		val memToReg_out = Output(UInt(1.W))
		val operandAsel_out = Output(UInt(2.W))
		val operandBsel_out = Output(UInt(1.W))
        val br_en_out = Output(UInt(1.W))
		val aluOp_out = Output(UInt(3.W))
		val regWrite_out = Output(UInt(1.W))
		val operandA_out = Output(SInt(32.W))
		val operandB_out = Output(SInt(32.W))
		val rd_out = Output(UInt(5.W))
		val func3_o=Output(UInt(3.W))
		val func7_o=Output(UInt(7.W))
		// val strData_out = Output(SInt(32.W))
		val rs1Ins_out = Output(UInt(5.W))
		val rs2Ins_out = Output(UInt(5.W))
		val pc_out = Output(UInt(32.W))
		val pc4_out = Output(UInt(32.W))
		
		val NextPc_out=Output(UInt(2.W))
		val imm_out=Output(SInt(32.W))
	})


	val reg_memWrite = RegInit(0.U(1.W))
	val reg_memRead = RegInit(0.U(1.W))
	val reg_fun3=RegInit(0.U(3.W))
	val reg_fun7=RegInit(0.U(7.W))
	val reg_memToReg = RegInit(0.U(1.W))
	val reg_operandAsel = RegInit(0.U(2.W))
	val reg_operandBsel = RegInit(0.U(1.W))
    val reg_br_en = RegInit(0.U(1.W))
	val reg_aluOp = RegInit(0.U(3.W))
	val reg_regWrite = RegInit(0.U(1.W))
	val reg_operandA = RegInit(0.S(32.W))
	val reg_operandB = RegInit(0.S(32.W))
	val reg_rd = RegInit(0.U(5.W))
	// val reg_strData = RegInit(0.S(32.W))
	val reg_rs1Ins = RegInit(0.U(5.W))
	val reg_rs2Ins = RegInit(0.U(5.W))
	val reg_pc = RegInit(0.U(32.W))
	val reg_pc4 = RegInit(0.U(32.W))
	
	val reg_NextPc = RegInit(0.U(2.W))
	val reg_imm =RegInit(0.S(32.W))


	reg_memWrite := io.memWrite_in
	reg_fun3:=io.func3
	reg_fun7:=io.func7
	reg_memRead := io.memRead_in
	reg_memToReg := io.memToReg_in
	reg_operandA := io.operandA_in
	reg_operandB := io.operandB_in
	reg_rd := io.rd_in
	// reg_strData := io.strData_in
	reg_aluOp := io.aluOp_in
	reg_regWrite := io.regWrite_in
	reg_rs1Ins := io.rs1Ins_in
	reg_rs2Ins := io.rs2Ins_in
	reg_operandAsel := io.operandAsel_in
	reg_operandBsel := io.operandBsel_in
    reg_br_en := io.br_en_in
	reg_pc := io.pc_in
	reg_pc4 := io.pc4_in
	
	reg_NextPc := io.NextPc
	reg_imm :=io.imm


	io.memWrite_out := reg_memWrite
	io.memRead_out := reg_memRead
	io.memToReg_out := reg_memToReg
	io.func3_o:=reg_fun3
	io.func7_o:=reg_fun7
	io.operandA_out := reg_operandA
	io.operandB_out := reg_operandB
	io.rd_out := reg_rd
	// io.strData_out := reg_strData
	io.aluOp_out := reg_aluOp
	io.regWrite_out := reg_regWrite
	io.rs1Ins_out := reg_rs1Ins
	io.rs2Ins_out := reg_rs2Ins
	io.operandAsel_out := reg_operandAsel
	io.operandBsel_out := reg_operandBsel
    io.br_en_out := reg_br_en
	io.pc_out := reg_pc
	io.pc4_out := reg_pc4
	
	io.NextPc_out := reg_NextPc
	io.imm_out:=reg_imm


}