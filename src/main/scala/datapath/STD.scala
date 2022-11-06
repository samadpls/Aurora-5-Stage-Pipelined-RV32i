package datapath
import chisel3._
class StructuralDetector extends Module {
  val io = IO(new Bundle {
    val rs1_sel = Input(UInt(5.W))
    val rs2_sel = Input(UInt(5.W))
    val MEM_WB_regWr = Input(Bool())
    val MEM_WB_REGRD = Input(UInt(5.W))
    val fwd_rs1 = Output(UInt(1.W))
    val fwd_rs2 = Output(UInt(1.W))
  })

  when(io.MEM_WB_regWr === 1.B &&  io.MEM_WB_REGRD === io.rs1_sel) {
    io.fwd_rs1 := 1.U
  } .otherwise {
    io.fwd_rs1 := 0.U
  }
  when(io.MEM_WB_regWr === 1.B && io.MEM_WB_REGRD === io.rs2_sel) {
    io.fwd_rs2 := 1.U
  } .otherwise {
    io.fwd_rs2 := 0.U
  }

}