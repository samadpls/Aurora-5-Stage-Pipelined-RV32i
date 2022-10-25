package controler
import chisel3._
import chisel3.util._
class alu_cont extends Bundle {
    val alu_op=Input(UInt(3.W))
    val func3=Input(UInt(3.W))
    val func7=Input(UInt(1.W))
    val x=Output(UInt(5.W))
    
}
class alu_controler extends Module{
    val io = IO (new alu_cont() )
    io.x:=0.U
    switch(io.alu_op){
        is("b001".U){
            io.x:=Cat("b00".U,io.func3)
        }
        is("b000".U){
            io.x:=Cat("b0".U,io.func7,io.func3)
        }
        is("b010".U){
            io.x:=Cat(io.alu_op(1,0),io.func3)
        }
        is("b011".U){
            io.x:=Fill(5,"b1".U)
        }
        is("b101".U){
            io.x:=Fill(5,"b0".U)
        }
        is("b100".U){
            io.x:=Fill(5,"b0".U)
        }
    }
}