package controler
import chisel3._
import org.scalatest._
import chiseltest._

class instmemtest  extends FreeSpec with ChiselScalatestTester {
    "inst mem Test" in {
        test(new InstMem()){c=>
        c.io.addr.poke(4.U)
        c.io.inst.expect(268439825.U)
        }
    }
}
