package controler
import chisel3._
import chisel3.util._
import chisel3.util . experimental.loadMemoryFromFile
class inst extends Bundle {
    val addr = Input ( UInt ( 10 . W ) )
    val inst = Output ( UInt ( 32 . W ) )
}

class InstMem extends Module{
    val io = IO (new inst() )
// INST_MEM_LEN in Bytes or INST_MEM_LEN / 4 in words
    val imem = Mem ( 32 , UInt ( 32.W ) )
    loadMemoryFromFile ( imem , "D:/merl/Scala-Chisel-Learning-Journey/src/main/scala/controler/text.txt" )
    io.inst := imem.read( io.addr )
}