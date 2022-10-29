package datapath
import chisel3._ 
import chisel3.util._ 

class EX extends Module{
    val io=IO(new Bundle{
        val memWrite_in = Input(UInt(1.W))
		val memRead_in = Input(UInt(1.W))
		val memToReg_in = Input(UInt(1.W))
		val rd_in = Input(UInt(5.W))
		val aluOutput_in = Input(SInt(32.W))
		//val strData_in = Input(SInt(32.W))
		val regWrite_in = Input(UInt(1.W))
		val rs2Sel_in = Input(UInt(5.W))
		val baseReg_in = Input(SInt(32.W))
		val offSet_in = Input(SInt(32.W))

		val memWrite_out = Output(UInt(1.W))
		val memRead_out = Output(UInt(1.W))
		val memToReg_out = Output(UInt(1.W))
		val rd_out = Output(UInt(5.W))
		//val strData_out = Output(SInt(32.W))
		val aluOutput_out = Output(SInt(32.W))
		val regWrite_out = Output(UInt(1.W))
		val rs2Sel_out = Output(UInt(5.W))
		val baseReg_out = Output(SInt(32.W))
		val offSet_out = Output(SInt(32.W))
    })
    val reg_memWrite = RegInit(0.U(1.W))
	val reg_memRead = RegInit(0.U(1.W))
	val reg_memToReg = RegInit(0.U(1.W))
	val reg_rd = RegInit(0.U(5.W))
	val reg_strData = RegInit(0.S(32.W))
	val reg_aluOutput = RegInit(0.S(32.W))
	val reg_regWrite = RegInit(0.U(1.W))
	val reg_rs2Sel = RegInit(0.U(5.W))
	val reg_baseReg = RegInit(0.S(32.W))
	val reg_offSet = RegInit(0.S(32.W))

	reg_memWrite := io.memWrite_in
	reg_memRead := io.memRead_in
	reg_memToReg := io.memToReg_in
	reg_rd := io.rd_in
	reg_strData := io.strData_in
	reg_aluOutput := io.aluOutput_in
	reg_regWrite := io.regWrite_in
	reg_rs2Sel := io.rs2Sel_in	
	reg_baseReg := io.baseReg_in
	reg_offSet := io.offSet_in
    
    io.memWrite_out := reg_memWrite
	io.memRead_out := reg_memRead
	io.memToReg_out := reg_memToReg
	io.rd_out := reg_rd
	io.strData_out := reg_strData
	io.aluOutput_out := reg_aluOutput
	io.regWrite_out := reg_regWrite
	io.rs2Sel_out := reg_rs2Sel
	io.baseReg_out := reg_baseReg
	io.offSet_out := reg_offSet


	



}