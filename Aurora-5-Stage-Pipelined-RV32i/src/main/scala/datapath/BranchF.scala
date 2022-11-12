package datapath

import chisel3._
import chisel3.util._
class DecodeBranchForward extends Module {
  val io = IO(new Bundle {
    val ID_EX_REGRD = Input(UInt(5.W))
    val ID_EX_MEMRD = Input(Bool())
    val EX_MEM_REGRD = Input(UInt(5.W))
    val EX_MEM_MEMRD = Input(Bool())
    val MEM_WB_REGRD = Input(UInt(5.W))
    val MEM_WB_MEMRD = Input(Bool())
    val rs1_sel = Input(UInt(5.W))
    val rs2_sel = Input(UInt(5.W))
    val ctrl_branch = Input(Bool())
    val forward_rs1 = Output(UInt(4.W))
    val forward_rs2 = Output(UInt(4.W))
    })
    io.forward_rs1 := 0.U
    io.forward_rs2 := 0.U
when(io.ctrl_branch === 1.U) {
  // ALU Hazard
  when(io.ID_EX_REGRD =/= "b00000".U && io.ID_EX_MEMRD =/= 1.U && (io.ID_EX_REGRD === io.rs1_sel) && (io.ID_EX_REGRD === io.rs2_sel)) {
    io.forward_rs1 := "b0001".U
    io.forward_rs2 := "b0001".U
  } .elsewhen(io.ID_EX_REGRD =/= "b00000".U && io.ID_EX_MEMRD =/= 1.U && (io.ID_EX_REGRD === io.rs1_sel)) {
    io.forward_rs1 := "b0001".U
  } .elsewhen(io.ID_EX_REGRD =/= "b00000".U && io.ID_EX_MEMRD =/= 1.U && (io.ID_EX_REGRD === io.rs2_sel)) {
    io.forward_rs2 := "b0001".U
  }

  // EX/MEM Hazard
  when(io.EX_MEM_REGRD =/= "b00000".U && io.EX_MEM_MEMRD =/= 1.U &&
    ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel) && (io.ID_EX_REGRD === io.rs2_sel)) &&
    (io.EX_MEM_REGRD === io.rs1_sel) && (io.EX_MEM_REGRD === io.rs2_sel)) {

    io.forward_rs1 := "b0010".U
    io.forward_rs2 := "b0010".U

  } .elsewhen(io.EX_MEM_REGRD =/= "b00000".U && io.EX_MEM_MEMRD =/= 1.U &&
    ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs2_sel)) &&
    (io.EX_MEM_REGRD === io.rs2_sel)) {

    io.forward_rs2 := "b0010".U

  } .elsewhen(io.EX_MEM_REGRD =/= "b00000".U && io.EX_MEM_MEMRD =/= 1.U &&
    ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel)) &&
    (io.EX_MEM_REGRD === io.rs1_sel)) {

    io.forward_rs1 := "b0010".U

  } .elsewhen(io.EX_MEM_REGRD =/= "b00000".U && io.EX_MEM_MEMRD === 1.U &&
    ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel) && (io.ID_EX_REGRD === io.rs2_sel)) &&
    (io.EX_MEM_REGRD === io.rs1_sel) && (io.EX_MEM_REGRD === io.rs2_sel)) {
    // FOR Load instructions
    io.forward_rs1 := "b0100".U
    io.forward_rs2 := "b0100".U

  } .elsewhen(io.EX_MEM_REGRD =/= "b00000".U && io.EX_MEM_MEMRD === 1.U &&
    ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs2_sel)) &&
    (io.EX_MEM_REGRD === io.rs2_sel)) {

    io.forward_rs2 := "b0100".U

  } .elsewhen(io.ctrl_branch === 1.U && io.EX_MEM_REGRD =/= "b00000".U && io.EX_MEM_MEMRD === 1.U &&
    ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel)) &&
    (io.EX_MEM_REGRD === io.rs1_sel)) {

    io.forward_rs1 := "b0100".U

  }

  // MEM/WB Hazard
  when(io.MEM_WB_REGRD =/= "b00000".U && io.MEM_WB_MEMRD =/= 1.U &&
    // IF NOT ALU HAZARD
    ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel) && (io.ID_EX_REGRD === io.rs2_sel)) &&
    // IF NOT EX/MEM HAZARD
    ~((io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.rs1_sel) && (io.EX_MEM_REGRD === io.rs2_sel)) &&
    (io.MEM_WB_REGRD === io.rs1_sel) && (io.MEM_WB_REGRD === io.rs2_sel)) {

    io.forward_rs1 := "b0011".U
    io.forward_rs2 := "b0011".U

  }
    .elsewhen(io.MEM_WB_REGRD =/= "b00000".U && io.MEM_WB_MEMRD =/= 1.U &&
      // IF NOT ALU HAZARD
      ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs2_sel)) &&
      // IF NOT EX/MEM HAZARD
      ~((io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.rs2_sel)) &&
      (io.MEM_WB_REGRD === io.rs2_sel)) {

      io.forward_rs2 := "b0011".U

    }
    .elsewhen(io.MEM_WB_REGRD =/= "b00000".U && io.MEM_WB_MEMRD =/= 1.U &&
      // IF NOT ALU HAZARD
      ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel)) &&
      // IF NOT EX/MEM HAZARD
      ~((io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.rs1_sel)) &&
      (io.MEM_WB_REGRD === io.rs1_sel)) {

      io.forward_rs1 := "b0011".U

    } .elsewhen(io.MEM_WB_REGRD =/= "b00000".U && io.MEM_WB_MEMRD === 1.U &&
    // IF NOT ALU HAZARD
    ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel) && (io.ID_EX_REGRD === io.rs2_sel)) &&
    // IF NOT EX/MEM HAZARD
    ~((io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.rs1_sel) && (io.EX_MEM_REGRD === io.rs2_sel)) &&
    (io.MEM_WB_REGRD === io.rs1_sel) && (io.MEM_WB_REGRD === io.rs2_sel)) {
    // FOR Load instructions
    io.forward_rs1 := "b0101".U
    io.forward_rs2 := "b0101".U

  }
    .elsewhen(io.MEM_WB_REGRD =/= "b00000".U && io.MEM_WB_MEMRD === 1.U &&
      // IF NOT ALU HAZARD
      ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs2_sel)) &&
      // IF NOT EX/MEM HAZARD
      ~((io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.rs2_sel)) &&
      (io.MEM_WB_REGRD === io.rs2_sel)) {

      io.forward_rs2 := "b0101".U

    }
    .elsewhen(io.MEM_WB_REGRD =/= "b00000".U && io.MEM_WB_MEMRD === 1.U &&
      // IF NOT ALU HAZARD
      ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel)) &&
      // IF NOT EX/MEM HAZARD
      ~((io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.rs1_sel))&&
      (io.MEM_WB_REGRD === io.rs1_sel)) {

      io.forward_rs1 := "b0101".U

    }

}
.elsewhen(io.ctrl_branch === 0.U) {
        // ALU Hazard
        when(io.ID_EX_REGRD =/= "b00000".U && io.ID_EX_MEMRD =/= 1.U && (io.ID_EX_REGRD === 	io.rs1_sel)){
          io.forward_rs1 := "b0110".U
        }

        // EX/MEM Hazard
        when(io.EX_MEM_REGRD =/= "b00000".U && io.EX_MEM_MEMRD =/= 1.U &&
          ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel)) &&
          (io.EX_MEM_REGRD === io.rs1_sel)) {

          io.forward_rs1 := "b0111".U

        }
          .elsewhen(io.EX_MEM_REGRD =/= "b00000".U && io.EX_MEM_MEMRD === 1.U &&
            ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel)) &&
            (io.EX_MEM_REGRD === io.rs1_sel)) {
            // FOR Load instructions
            io.forward_rs1 := "b1001".U

        }


        // MEM/WB Hazard
        when(io.MEM_WB_REGRD =/= "b00000".U && io.MEM_WB_MEMRD =/= 1.U &&
          // IF NOT ALU HAZARD
          ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel)) &&
          // IF NOT EX/MEM HAZARD
          ~((io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.rs1_sel)) &&
          (io.MEM_WB_REGRD === io.rs1_sel)) {

          io.forward_rs1 := "b1000".U

        }
           .elsewhen(io.MEM_WB_REGRD =/= "b00000".U && io.MEM_WB_MEMRD === 1.U &&
          // IF NOT ALU HAZARD
          ~((io.ID_EX_REGRD =/= "b00000".U) && (io.ID_EX_REGRD === io.rs1_sel)) &&
          // IF NOT EX/MEM HAZARD
          ~((io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.rs1_sel)) &&
          (io.MEM_WB_REGRD === io.rs1_sel)) {
          // FOR Load instructions
          io.forward_rs1 := "b1010".U

        }


      }
}