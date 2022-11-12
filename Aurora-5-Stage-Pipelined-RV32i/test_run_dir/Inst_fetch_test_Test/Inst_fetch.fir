;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit Inst_fetch : 
  module Inst_fetch : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip pc_in : UInt<32>, flip pc4_in : UInt<32>, flip ins_in : UInt<32>, pc_out : UInt<32>, ins_out : UInt<32>, pc4_out : UInt<32>}
    
    reg reg_pc : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Inst_fetch.scala 24:29]
    reg reg_pc4 : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Inst_fetch.scala 25:30]
    reg reg_ins : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Inst_fetch.scala 26:30]
    reg_pc <= io.pc_in @[Inst_fetch.scala 28:16]
    reg_pc4 <= io.pc4_in @[Inst_fetch.scala 29:17]
    reg_ins <= io.ins_in @[Inst_fetch.scala 30:17]
    io.pc_out <= reg_pc @[Inst_fetch.scala 32:19]
    io.pc4_out <= reg_pc4 @[Inst_fetch.scala 33:20]
    io.ins_out <= reg_ins @[Inst_fetch.scala 34:20]
    
