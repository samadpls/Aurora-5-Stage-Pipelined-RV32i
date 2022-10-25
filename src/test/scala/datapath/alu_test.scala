package controler
import chisel3._
import org.scalatest._
import chiseltest._

class ALU4test  extends FreeSpec with ChiselScalatestTester {
    "ALU4  Test" in {
        test(new ALU4()){c=>
        c.io.alu_Op.poke("b00000".U)
        c.io.in1.poke(1.S)
        c.io.in2.poke(1.S)
        c.clock.step(10)
        c.io.out.expect(2.S)
        }
    }
}