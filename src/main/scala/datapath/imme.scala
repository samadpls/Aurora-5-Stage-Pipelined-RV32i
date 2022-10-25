package controler
import chisel3._
import chisel3.util._

class ImmdValGen extends Bundle {
    val instr = Input ( UInt (32. W ) )
    val pc_val = Input(UInt(32.W))
	val s_imm = Output(SInt(32.W))
	val sb_imm = Output(SInt(32.W))
	val uj_imm = Output(SInt(32.W))
	val u_imm = Output(SInt(32.W))
	val i_imm = Output(SInt(32.W))
}

class ImmdValGen1 extends Module {
    val io = IO (new ImmdValGen )
// Start coding here

    //val temp = 0.U
    //S
	val s_imm13 = Cat (io.instr(31,25),io.instr(11,7))
	io.s_imm := (Cat(Fill(20,s_imm13(11)),s_imm13)).asSInt
	//SB
	val sb_imm13 = Cat (io.instr(31),io.instr(7),io.instr(30,25),io.instr(11,8),"b0".U)
	io.sb_imm := ((Cat(Fill(19,sb_imm13(12)),sb_imm13)) + io.pc_val).asSInt
	//UJ
	val uj_imm21 = Cat (io.instr(31),io.instr(19,12),io.instr(20),io.instr(30,21),"b0".U)
	io.uj_imm := ((Cat(Fill(12,uj_imm21(20)),uj_imm21)) + io.pc_val).asSInt
	//U
	io.u_imm := ((Cat(Fill(12,io.instr(31)),io.instr(31,12))) << 12).asSInt
	//I
	io.i_imm := (Cat(Fill(20,io.instr(31)),io.instr(31,20))).asSInt
}