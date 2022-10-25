;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit MEM_WB : 
  module MEM_WB : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip memToReg_in : UInt<1>, flip rd_in : UInt<5>, flip dataOut_in : SInt<32>, flip aluOutput_in : SInt<32>, flip regWrite_in : UInt<1>, flip rs2Sel_in : UInt<5>, flip baseReg_in : SInt<32>, flip offSet_in : SInt<32>, flip MemRead_in : UInt<1>, flip memWrite_in : UInt<1>, memToReg_out : UInt<1>, rd_out : UInt<5>, dataOut_out : SInt<32>, aluOutput_out : SInt<32>, regWrite_out : UInt<1>, rs2Sel_out : UInt<5>, baseReg_out : SInt<32>, offSet_out : SInt<32>, MemRead_out : UInt<1>, memWrite_out : UInt<1>}
    
    reg reg_memToReg : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Mem_WB.scala 37:35]
    reg reg_rd : UInt<5>, clock with : (reset => (reset, UInt<5>("h00"))) @[Mem_WB.scala 38:29]
    reg reg_dataOut : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[Mem_WB.scala 39:34]
    reg reg_aluOutput : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[Mem_WB.scala 40:36]
    reg reg_regWrite : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Mem_WB.scala 41:35]
    reg reg_rs2Sel : UInt<5>, clock with : (reset => (reset, UInt<5>("h00"))) @[Mem_WB.scala 42:33]
    reg reg_baseReg : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[Mem_WB.scala 43:34]
    reg reg_offSet : SInt<32>, clock with : (reset => (reset, asSInt(UInt<32>("h00")))) @[Mem_WB.scala 44:33]
    reg reg_memRead : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Mem_WB.scala 45:34]
    reg reg_memWrite : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Mem_WB.scala 46:35]
    reg_memToReg <= io.memToReg_in @[Mem_WB.scala 49:22]
    reg_rd <= io.rd_in @[Mem_WB.scala 50:16]
    reg_dataOut <= io.dataOut_in @[Mem_WB.scala 51:21]
    reg_aluOutput <= io.aluOutput_in @[Mem_WB.scala 52:23]
    reg_regWrite <= io.regWrite_in @[Mem_WB.scala 53:22]
    reg_rs2Sel <= io.rs2Sel_in @[Mem_WB.scala 54:20]
    reg_baseReg <= io.baseReg_in @[Mem_WB.scala 55:21]
    reg_offSet <= io.offSet_in @[Mem_WB.scala 56:20]
    reg_memRead <= io.MemRead_in @[Mem_WB.scala 57:21]
    reg_memWrite <= io.memWrite_in @[Mem_WB.scala 58:22]
    io.memToReg_out <= reg_memToReg @[Mem_WB.scala 61:25]
    io.rd_out <= reg_rd @[Mem_WB.scala 62:19]
    io.dataOut_out <= reg_dataOut @[Mem_WB.scala 63:24]
    io.aluOutput_out <= reg_aluOutput @[Mem_WB.scala 64:26]
    io.regWrite_out <= reg_regWrite @[Mem_WB.scala 65:25]
    io.rs2Sel_out <= reg_rs2Sel @[Mem_WB.scala 66:23]
    io.baseReg_out <= reg_baseReg @[Mem_WB.scala 67:24]
    io.offSet_out <= reg_offSet @[Mem_WB.scala 68:23]
    io.MemRead_out <= reg_memRead @[Mem_WB.scala 69:24]
    io.memWrite_out <= reg_memWrite @[Mem_WB.scala 70:25]
    
