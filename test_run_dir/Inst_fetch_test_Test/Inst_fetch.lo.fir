circuit Inst_fetch :
  module Inst_fetch :
    input clock : Clock
    input reset : UInt<1>
    input io_pc_in : UInt<32>
    input io_pc4_in : UInt<32>
    input io_ins_in : UInt<32>
    output io_pc_out : UInt<32>
    output io_ins_out : UInt<32>
    output io_pc4_out : UInt<32>

    reg reg_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_pc) @[Inst_fetch.scala 24:29]
    reg reg_pc4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_pc4) @[Inst_fetch.scala 25:30]
    reg reg_ins : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_ins) @[Inst_fetch.scala 26:30]
    io_pc_out <= reg_pc @[Inst_fetch.scala 32:19]
    io_ins_out <= reg_ins @[Inst_fetch.scala 34:20]
    io_pc4_out <= reg_pc4 @[Inst_fetch.scala 33:20]
    reg_pc <= mux(reset, UInt<32>("h0"), io_pc_in) @[Inst_fetch.scala 24:29 Inst_fetch.scala 24:29 Inst_fetch.scala 28:16]
    reg_pc4 <= mux(reset, UInt<32>("h0"), io_pc4_in) @[Inst_fetch.scala 25:30 Inst_fetch.scala 25:30 Inst_fetch.scala 29:17]
    reg_ins <= mux(reset, UInt<32>("h0"), io_ins_in) @[Inst_fetch.scala 26:30 Inst_fetch.scala 26:30 Inst_fetch.scala 30:17]
