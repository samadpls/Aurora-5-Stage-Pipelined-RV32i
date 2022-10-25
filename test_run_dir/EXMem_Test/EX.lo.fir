circuit EX :
  module EX :
    input clock : Clock
    input reset : UInt<1>
    input io_memWrite_in : UInt<1>
    input io_memRead_in : UInt<1>
    input io_memToReg_in : UInt<1>
    input io_rd_in : UInt<5>
    input io_aluOutput_in : SInt<32>
    input io_strData_in : SInt<32>
    input io_regWrite_in : UInt<1>
    input io_rs2Sel_in : UInt<5>
    input io_baseReg_in : SInt<32>
    input io_offSet_in : SInt<32>
    output io_memWrite_out : UInt<1>
    output io_memRead_out : UInt<1>
    output io_memToReg_out : UInt<1>
    output io_rd_out : UInt<5>
    output io_strData_out : SInt<32>
    output io_aluOutput_out : SInt<32>
    output io_regWrite_out : UInt<1>
    output io_rs2Sel_out : UInt<5>
    output io_baseReg_out : SInt<32>
    output io_offSet_out : SInt<32>

    reg reg_memWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memWrite) @[EX.scala 29:31]
    reg reg_memRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memRead) @[EX.scala 30:34]
    reg reg_memToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memToReg) @[EX.scala 31:35]
    reg reg_rd : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rd) @[EX.scala 32:29]
    reg reg_strData : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_strData) @[EX.scala 33:34]
    reg reg_aluOutput : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_aluOutput) @[EX.scala 34:36]
    reg reg_regWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_regWrite) @[EX.scala 35:35]
    reg reg_rs2Sel : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rs2Sel) @[EX.scala 36:33]
    reg reg_baseReg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_baseReg) @[EX.scala 37:34]
    reg reg_offSet : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_offSet) @[EX.scala 38:33]
    io_memWrite_out <= reg_memWrite @[EX.scala 51:21]
    io_memRead_out <= reg_memRead @[EX.scala 52:24]
    io_memToReg_out <= reg_memToReg @[EX.scala 53:25]
    io_rd_out <= reg_rd @[EX.scala 54:19]
    io_strData_out <= reg_strData @[EX.scala 55:24]
    io_aluOutput_out <= reg_aluOutput @[EX.scala 56:26]
    io_regWrite_out <= reg_regWrite @[EX.scala 57:25]
    io_rs2Sel_out <= reg_rs2Sel @[EX.scala 58:23]
    io_baseReg_out <= reg_baseReg @[EX.scala 59:24]
    io_offSet_out <= reg_offSet @[EX.scala 60:23]
    reg_memWrite <= mux(reset, UInt<1>("h0"), io_memWrite_in) @[EX.scala 29:31 EX.scala 29:31 EX.scala 40:22]
    reg_memRead <= mux(reset, UInt<1>("h0"), io_memRead_in) @[EX.scala 30:34 EX.scala 30:34 EX.scala 41:21]
    reg_memToReg <= mux(reset, UInt<1>("h0"), io_memToReg_in) @[EX.scala 31:35 EX.scala 31:35 EX.scala 42:22]
    reg_rd <= mux(reset, UInt<5>("h0"), io_rd_in) @[EX.scala 32:29 EX.scala 32:29 EX.scala 43:16]
    reg_strData <= mux(reset, asSInt(UInt<32>("h0")), io_strData_in) @[EX.scala 33:34 EX.scala 33:34 EX.scala 44:21]
    reg_aluOutput <= mux(reset, asSInt(UInt<32>("h0")), io_aluOutput_in) @[EX.scala 34:36 EX.scala 34:36 EX.scala 45:23]
    reg_regWrite <= mux(reset, UInt<1>("h0"), io_regWrite_in) @[EX.scala 35:35 EX.scala 35:35 EX.scala 46:22]
    reg_rs2Sel <= mux(reset, UInt<5>("h0"), io_rs2Sel_in) @[EX.scala 36:33 EX.scala 36:33 EX.scala 47:20]
    reg_baseReg <= mux(reset, asSInt(UInt<32>("h0")), io_baseReg_in) @[EX.scala 37:34 EX.scala 37:34 EX.scala 48:21]
    reg_offSet <= mux(reset, asSInt(UInt<32>("h0")), io_offSet_in) @[EX.scala 38:33 EX.scala 38:33 EX.scala 49:20]
