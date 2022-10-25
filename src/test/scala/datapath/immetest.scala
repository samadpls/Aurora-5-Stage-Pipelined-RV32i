package controler
import chisel3._
import org.scalatest._
import chiseltest._
class immdetest2 extends FreeSpec with ChiselScalatestTester{
    "immediate Test" in {
        test(new ImmdValGen1()){c=>
        c.io.instr.poke("h00200213".U)
        c.io.pc_val.poke("b0101010101101010101010100000000".U)
        c.clock.step(1)
        // c.io.immd_se.expect(716527530.U)

        }
    }
}