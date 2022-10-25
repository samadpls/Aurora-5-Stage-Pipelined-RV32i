package controler
import chisel3._
import chisel3.util._

class reg extends Module{
	val io = IO(new Bundle{  
		val write = Input(UInt(1.W))
		val rs1 = Input(UInt(5.W))
		val rs2 = Input(UInt(5.W))
		val rd = Input(UInt(5.W))
		val WriteData = Input(SInt(32.W))

		val rd1 = Output(SInt(32.W)) 
		val rd2 = Output(SInt(32.W))
	})
	
	val register = RegInit(VecInit(Seq.fill(32)(0.S(32.W))))	
	register(0) := (0.S)
	dontTouch(io.rd1)
	dontTouch(io.rd2)
	io.rd1 := register(io.rs1)
	io.rd2 := register(io.rs2)
	
	when(io.write === 1.U){
		when(io.rd === "b00000".U){
			register(io.rd) := 0.S
		}.otherwise{
			register(io.rd) := io.WriteData
		}
	}
}
