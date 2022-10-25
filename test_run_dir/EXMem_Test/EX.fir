;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit EX : 
  module EX : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip memWrite_in : UInt<1>, flip memRead_in : UInt<1>, flip memToReg_in : UInt<1>, flip rd_in : UInt<5>, flip aluOutput_in : SInt<32>, flip strData_in : SInt<32>, flip regWrite_in : UInt<1>, flip rs2Sel_in : UInt<5>, flip baseReg_in : SInt<32>, flip offSet_in : SInt<32>, memWrite_out : UInt<1>, memRead_out : UInt<1>, memToReg_out : UInt<1>, rd_out : UInt<5>, strData_out : SInt<32>, aluOutput_out : SInt<32>, regWrite_out : UInt<1>, rs2Sel_out : UInt<5>, baseReg_out : SInt<32>, offSet_out : SInt<32>}
    
    reg reg_memWrite : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[EX.scala 29:31]
    reg reg_memRead : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[EX.scala 30:34]
    reg reg_memToReg : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[EX.scala 31:35]
    reg reg_rd : UInt<5>, clock with : (reset => (reset, UInt<5>("h00"))) @[EX.scala 32:29]
    reg reg_strData : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[EX.scala 33:34]
    reg reg_aluOutput : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[EX.scala 34:36]
    reg reg_regWrite : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[EX.scala 35:35]
    reg reg_rs2Sel : UInt<5>, clock with : (reset => (reset, UInt<5>("h00"))) @[EX.scala 36:33]
    reg reg_baseReg : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[EX.scala 37:34]
    reg reg_offSet : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[EX.scala 38:33]
    reg_memWrite <= io.memWrite_in @[EX.scala 40:22]
    reg_memRead <= io.memRead_in @[EX.scala 41:21]
    reg_memToReg <= io.memToReg_in @[EX.scala 42:22]
    reg_rd <= io.rd_in @[EX.scala 43:16]
    reg_strData <= io.strData_in @[EX.scala 44:21]
    reg_aluOutput <= io.aluOutput_in @[EX.scala 45:23]
    reg_regWrite <= io.regWrite_in @[EX.scala 46:22]
    reg_rs2Sel <= io.rs2Sel_in @[EX.scala 47:20]
    reg_baseReg <= io.baseReg_in @[EX.scala 48:21]
    reg_offSet <= io.offSet_in @[EX.scala 49:20]
    io.memWrite_out <= reg_memWrite @[EX.scala 51:21]
    io.memRead_out <= reg_memRead @[EX.scala 52:24]
    io.memToReg_out <= reg_memToReg @[EX.scala 53:25]
    io.rd_out <= reg_rd @[EX.scala 54:19]
    io.strData_out <= reg_strData @[EX.scala 55:24]
    io.aluOutput_out <= reg_aluOutput @[EX.scala 56:26]
    io.regWrite_out <= reg_regWrite @[EX.scala 57:25]
    io.rs2Sel_out <= reg_rs2Sel @[EX.scala 58:23]
    io.baseReg_out <= reg_baseReg @[EX.scala 59:24]
    io.offSet_out <= reg_offSet @[EX.scala 60:23]
    
