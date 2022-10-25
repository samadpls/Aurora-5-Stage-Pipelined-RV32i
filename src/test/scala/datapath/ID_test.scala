package datapath
import chisel3._
import org.scalatest._
import chiseltest._
class ID_test extends FreeSpec with ChiselScalatestTester{
    "InstructionDecode Test" in {
        test(new ID()){c=>
        c.clock.step(10)
        
        }
    }
}