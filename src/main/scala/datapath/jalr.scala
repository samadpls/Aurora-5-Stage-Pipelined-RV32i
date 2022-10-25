package controler
import chisel3._
import chisel3.util._
class jalr_io extends Bundle {
    val addr = Input ( SInt (32.W ) )
    val pc_addr=Input(SInt(32.W))
    val out = Output ( SInt (32.W ) )
}
class jalr extends Module {
    val io = IO (new jalr_io() )        
    io.out:= (io.addr+io.pc_addr) & 4294967294L.S
    }