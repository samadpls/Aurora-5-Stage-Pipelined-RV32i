package controler
import chisel3._
import chisel3.util._
class pc extends Bundle {
     val addr=Input(UInt(32.W))
     val pc_4=Output(UInt(32.W))
     val pc_out=Output(UInt(32.W))

}
class pccounter extends Module {
        val io = IO (new pc())
        val reg=RegInit(0.U(32.W))
      
        reg:=io.addr
        io.pc_out:=reg
        io.pc_4:=reg+4.U
       
        
    } 