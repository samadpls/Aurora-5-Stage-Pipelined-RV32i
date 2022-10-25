package datapath

import chisel3._
import org.scalatest._
import chiseltest._

class MEM_WB_test extends FreeSpec with ChiselScalatestTester {
    "Mem WB Test" in {
        test(new MEM_WB()){c=>
        c.clock.step(5)
        }
    }
}    