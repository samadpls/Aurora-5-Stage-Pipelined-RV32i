package datapath
import chisel3._
import org.scalatest._
import chiseltest._
class EX_test extends FreeSpec with ChiselScalatestTester{
    "EXMem Test" in {
        test(new EX()){c=>
        c.clock.step(10)
        
        }
    }
}