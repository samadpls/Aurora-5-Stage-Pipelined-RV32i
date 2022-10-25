package controler
import chisel3._
import org.scalatest._
import chiseltest._

class regtest  extends FreeSpec with ChiselScalatestTester {
    "reg Test" in {
        test(new reg()){c=>
        c.io.write.poke(1.U)
        c.io.rs1.poke(5.U)
        c.io.rs2.poke(4.U)
        c.io.rd.poke(1.U)
        c.io.WriteData.poke(5.S)
        c.clock.step(10)
        // c.io.rd1.expect(0.S)
        // c.io.rd2.expect(0.S)
        }
    }
        
}