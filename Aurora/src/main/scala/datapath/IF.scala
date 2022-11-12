package datapath

import chisel3._
import chisel3.util._

class Inst_fetch extends Module{

	val io = IO(new Bundle{

		val pc_in = Input(UInt(32.W))
		val pc4_in = Input(UInt(32.W))
		val ins_in = Input(UInt(32.W))
		val pc_out = Output(UInt(32.W))
		val ins_out = Output(UInt(32.W))
		val pc4_out = Output(UInt(32.W))
		

	})
    //At the start of a cycle, the address is presented to instruction memory. 
    //Then during the cycle, the instruction is being read out of instruction memory, and at the 
    //same time a calculation is done to determine the next PC. The calculation of the next PC is done by incrementing the PC by 4, 
    //and by choosing whether to take that as the next PC or alternatively to take the result of a branch / jump calculation as the next PC.

	val reg_pc = RegInit(0.U(32.W))
	val reg_pc4 = RegInit(0.U(32.W))
	val reg_ins = RegInit(0.U(32.W))

	reg_pc := io.pc_in
	reg_pc4 := io.pc4_in
	reg_ins := io.ins_in

	io.pc_out := reg_pc 
	io.pc4_out := reg_pc4
	io.ins_out := reg_ins


}