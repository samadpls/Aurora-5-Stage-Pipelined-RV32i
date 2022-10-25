package controler
import chisel3._
import org.scalatest._
import chiseltest._
class jalrtest extends FreeSpec with ChiselScalatestTester{
    "jalr Test" in {
        test(new jalr()){c=>
        c.io.addr.poke(1.S)
        c.io.pc_addr.poke(4.S)
        c.clock.step(10)
        c.io.out.expect(4.S)
        }
    }
}