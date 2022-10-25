package datapath

import chisel3._
import org.scalatest._
import chiseltest._

class Inst_fetch_test extends FreeSpec with ChiselScalatestTester {
    "Inst_fetch_test Test" in {
        test(new Inst_fetch()){c=>
        c.io.pc_in.poke(1.U)
        c.io.pc4_in.poke(1.U)
        c.io.ins_in.poke(1.U)
        c.clock.step(5)
        c.io.pc_out.expect(1.U)
        c.io.ins_out.expect(1.U)
        c.io.pc4_out.expect(1.U)

        }
    }
}    