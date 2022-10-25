circuit MEM_WB :
  module MEM_WB :
    input clock : Clock
    input reset : UInt<1>
    input io_memToReg_in : UInt<1>
    input io_rd_in : UInt<5>
    input io_dataOut_in : SInt<32>
    input io_aluOutput_in : SInt<32>
    input io_regWrite_in : UInt<1>
    input io_rs2Sel_in : UInt<5>
    input io_baseReg_in : SInt<32>
    input io_offSet_in : SInt<32>
    input io_MemRead_in : UInt<1>
    input io_memWrite_in : UInt<1>
    output io_memToReg_out : UInt<1>
    output io_rd_out : UInt<5>
    output io_dataOut_out : SInt<32>
    output io_aluOutput_out : SInt<32>
    output io_regWrite_out : UInt<1>
    output io_rs2Sel_out : UInt<5>
    output io_baseReg_out : SInt<32>
    output io_offSet_out : SInt<32>
    output io_MemRead_out : UInt<1>
    output io_memWrite_out : UInt<1>

    reg reg_memToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memToReg) @[Mem_WB.scala 37:35]
    reg reg_rd : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rd) @[Mem_WB.scala 38:29]
    reg reg_dataOut : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_dataOut) @[Mem_WB.scala 39:34]
    reg reg_aluOutput : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_aluOutput) @[Mem_WB.scala 40:36]
    reg reg_regWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_regWrite) @[Mem_WB.scala 41:35]
    reg reg_rs2Sel : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rs2Sel) @[Mem_WB.scala 42:33]
    reg reg_baseReg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_baseReg) @[Mem_WB.scala 43:34]
    reg reg_offSet : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_offSet) @[Mem_WB.scala 44:33]
    reg reg_memRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memRead) @[Mem_WB.scala 45:34]
    reg reg_memWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memWrite) @[Mem_WB.scala 46:35]
    io_memToReg_out <= reg_memToReg @[Mem_WB.scala 61:25]
    io_rd_out <= reg_rd @[Mem_WB.scala 62:19]
    io_dataOut_out <= reg_dataOut @[Mem_WB.scala 63:24]
    io_aluOutput_out <= reg_aluOutput @[Mem_WB.scala 64:26]
    io_regWrite_out <= reg_regWrite @[Mem_WB.scala 65:25]
    io_rs2Sel_out <= reg_rs2Sel @[Mem_WB.scala 66:23]
    io_baseReg_out <= reg_baseReg @[Mem_WB.scala 67:24]
    io_offSet_out <= reg_offSet @[Mem_WB.scala 68:23]
    io_MemRead_out <= reg_memRead @[Mem_WB.scala 69:24]
    io_memWrite_out <= reg_memWrite @[Mem_WB.scala 70:25]
    reg_memToReg <= mux(reset, UInt<1>("h0"), io_memToReg_in) @[Mem_WB.scala 37:35 Mem_WB.scala 37:35 Mem_WB.scala 49:22]
    reg_rd <= mux(reset, UInt<5>("h0"), io_rd_in) @[Mem_WB.scala 38:29 Mem_WB.scala 38:29 Mem_WB.scala 50:16]
    reg_dataOut <= mux(reset, asSInt(UInt<32>("h0")), io_dataOut_in) @[Mem_WB.scala 39:34 Mem_WB.scala 39:34 Mem_WB.scala 51:21]
    reg_aluOutput <= mux(reset, asSInt(UInt<32>("h0")), io_aluOutput_in) @[Mem_WB.scala 40:36 Mem_WB.scala 40:36 Mem_WB.scala 52:23]
    reg_regWrite <= mux(reset, UInt<1>("h0"), io_regWrite_in) @[Mem_WB.scala 41:35 Mem_WB.scala 41:35 Mem_WB.scala 53:22]
    reg_rs2Sel <= mux(reset, UInt<5>("h0"), io_rs2Sel_in) @[Mem_WB.scala 42:33 Mem_WB.scala 42:33 Mem_WB.scala 54:20]
    reg_baseReg <= mux(reset, asSInt(UInt<32>("h0")), io_baseReg_in) @[Mem_WB.scala 43:34 Mem_WB.scala 43:34 Mem_WB.scala 55:21]
    reg_offSet <= mux(reset, asSInt(UInt<32>("h0")), io_offSet_in) @[Mem_WB.scala 44:33 Mem_WB.scala 44:33 Mem_WB.scala 56:20]
    reg_memRead <= mux(reset, UInt<1>("h0"), io_MemRead_in) @[Mem_WB.scala 45:34 Mem_WB.scala 45:34 Mem_WB.scala 57:21]
    reg_memWrite <= mux(reset, UInt<1>("h0"), io_memWrite_in) @[Mem_WB.scala 46:35 Mem_WB.scala 46:35 Mem_WB.scala 58:22]
