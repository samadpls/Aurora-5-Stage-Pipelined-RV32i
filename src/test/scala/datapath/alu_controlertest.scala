package controler
import chisel3._
import org.scalatest._
import chiseltest._

class alu_cont_test  extends FreeSpec with ChiselScalatestTester {
    "alu_controler  Test" in {
        test(new alu_controler()){c=>
        c.io.alu_op.poke("b010".U)
        c.io.func3.poke("b000".U)
        c.io.func7.poke("b1".U)
        c.clock.step(10)
        c.io.x.expect("b10000".U)
        }
    }
}