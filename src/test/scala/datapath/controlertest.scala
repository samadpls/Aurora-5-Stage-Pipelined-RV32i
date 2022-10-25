package controler
import chisel3._
import org.scalatest._
import chiseltest._

class cntrolert  extends FreeSpec with ChiselScalatestTester {
    "controler Test" in {
        test(new controler()){c=>
        c.io.opcod.poke("b0110011".U)
        c.clock.step(1)
        c.io.memwrite.expect(0.B)
        c.io.branch.expect(0.B)
        c.io.memread.expect(0.B)
        c.io.regwrite.expect(1.B)
        c.io.memtoreg.expect(0.B)
        c.io.aluop.expect("b000".U)
        c.io.op_a.expect("b00".U)
        c.io.op_b.expect(0.B)
        c.io.extend_sel.expect(0.U)
        c.io.next_pc.expect("b00".U)

        }
        }
        }