// package controler
// import chisel3._
// import org.scalatest._
// import chiseltest._

// class datamemt  extends FreeSpec with ChiselScalatestTester {
//     "data mem Test" in {
//         test(new datamem()){c=>
//         c.io.writeaddr.poke(4.U)
//         c.io.writedata.poke(4.U)
//         c.io.read_add.poke(4.U)
//         c.io.write_en.poke(1.B)
//         c.io.read_en.poke(0.B)
//         c.clock.step(1)
//         c.io.out.expect(4.U)
//         }
//     }
// }