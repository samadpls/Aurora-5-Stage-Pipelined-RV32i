circuit ID :
  module ID :
    input clock : Clock
    input reset : UInt<1>
    input io_memWrite_in : UInt<1>
    input io_memRead_in : UInt<1>
    input io_memToReg_in : UInt<1>
    input io_operandA_in : SInt<32>
    input io_operandB_in : SInt<32>
    input io_rd_in : UInt<5>
    input io_strData_in : SInt<32>
    input io_aluCtrl_in : UInt<5>
    input io_regWrite_in : UInt<1>
    input io_rs1Ins_in : UInt<5>
    input io_rs2Ins_in : UInt<5>
    input io_operandAsel_in : UInt<2>
    input io_operandBsel_in : UInt<1>
    input io_hazard_in : UInt<1>
    input io_pc_in : UInt<32>
    input io_pc4_in : UInt<32>
    output io_memWrite_out : UInt<1>
    output io_memRead_out : UInt<1>
    output io_memToReg_out : UInt<1>
    output io_operandA_out : SInt<32>
    output io_operandB_out : SInt<32>
    output io_rd_out : UInt<5>
    output io_strData_out : SInt<32>
    output io_aluCtrl_out : UInt<5>
    output io_regWrite_out : UInt<1>
    output io_rs1Ins_out : UInt<5>
    output io_rs2Ins_out : UInt<5>
    output io_operandAsel_out : UInt<2>
    output io_operandBsel_out : UInt<1>
    output io_hazard_out : UInt<1>
    output io_pc_out : UInt<32>
    output io_pc4_out : UInt<32>

    reg reg_memWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memWrite) @[ID.scala 43:35]
    reg reg_memRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memRead) @[ID.scala 44:34]
    reg reg_memToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memToReg) @[ID.scala 45:35]
    reg reg_operandA : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_operandA) @[ID.scala 46:35]
    reg reg_operandB : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_operandB) @[ID.scala 47:35]
    reg reg_rd : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rd) @[ID.scala 48:29]
    reg reg_strData : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_strData) @[ID.scala 49:34]
    reg reg_aluCtrl : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_aluCtrl) @[ID.scala 50:34]
    reg reg_regWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_regWrite) @[ID.scala 51:35]
    reg reg_rs1Ins : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rs1Ins) @[ID.scala 52:33]
    reg reg_rs2Ins : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rs2Ins) @[ID.scala 53:33]
    reg reg_operandAsel : UInt<2>, clock with :
      reset => (UInt<1>("h0"), reg_operandAsel) @[ID.scala 54:38]
    reg reg_operandBsel : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_operandBsel) @[ID.scala 55:38]
    reg reg_hazard : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_hazard) @[ID.scala 56:33]
    reg reg_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_pc) @[ID.scala 57:29]
    reg reg_pc4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_pc4) @[ID.scala 58:30]
    io_memWrite_out <= reg_memWrite @[ID.scala 79:25]
    io_memRead_out <= reg_memRead @[ID.scala 80:24]
    io_memToReg_out <= reg_memToReg @[ID.scala 81:25]
    io_operandA_out <= reg_operandA @[ID.scala 82:25]
    io_operandB_out <= reg_operandB @[ID.scala 83:25]
    io_rd_out <= reg_rd @[ID.scala 84:19]
    io_strData_out <= reg_strData @[ID.scala 85:24]
    io_aluCtrl_out <= reg_aluCtrl @[ID.scala 86:24]
    io_regWrite_out <= reg_regWrite @[ID.scala 87:25]
    io_rs1Ins_out <= reg_rs1Ins @[ID.scala 88:23]
    io_rs2Ins_out <= reg_rs2Ins @[ID.scala 89:23]
    io_operandAsel_out <= reg_operandAsel @[ID.scala 90:28]
    io_operandBsel_out <= reg_operandBsel @[ID.scala 91:28]
    io_hazard_out <= reg_hazard @[ID.scala 92:23]
    io_pc_out <= reg_pc @[ID.scala 93:19]
    io_pc4_out <= reg_pc4 @[ID.scala 94:20]
    reg_memWrite <= mux(reset, UInt<1>("h0"), io_memWrite_in) @[ID.scala 43:35 ID.scala 43:35 ID.scala 61:22]
    reg_memRead <= mux(reset, UInt<1>("h0"), io_memRead_in) @[ID.scala 44:34 ID.scala 44:34 ID.scala 62:21]
    reg_memToReg <= mux(reset, UInt<1>("h0"), io_memToReg_in) @[ID.scala 45:35 ID.scala 45:35 ID.scala 63:22]
    reg_operandA <= mux(reset, asSInt(UInt<32>("h0")), io_operandA_in) @[ID.scala 46:35 ID.scala 46:35 ID.scala 64:22]
    reg_operandB <= mux(reset, asSInt(UInt<32>("h0")), io_operandB_in) @[ID.scala 47:35 ID.scala 47:35 ID.scala 65:22]
    reg_rd <= mux(reset, UInt<5>("h0"), io_rd_in) @[ID.scala 48:29 ID.scala 48:29 ID.scala 66:16]
    reg_strData <= mux(reset, asSInt(UInt<32>("h0")), io_strData_in) @[ID.scala 49:34 ID.scala 49:34 ID.scala 67:21]
    reg_aluCtrl <= mux(reset, UInt<5>("h0"), io_aluCtrl_in) @[ID.scala 50:34 ID.scala 50:34 ID.scala 68:21]
    reg_regWrite <= mux(reset, UInt<1>("h0"), io_regWrite_in) @[ID.scala 51:35 ID.scala 51:35 ID.scala 69:22]
    reg_rs1Ins <= mux(reset, UInt<5>("h0"), io_rs1Ins_in) @[ID.scala 52:33 ID.scala 52:33 ID.scala 70:20]
    reg_rs2Ins <= mux(reset, UInt<5>("h0"), io_rs2Ins_in) @[ID.scala 53:33 ID.scala 53:33 ID.scala 71:20]
    reg_operandAsel <= mux(reset, UInt<2>("h0"), io_operandAsel_in) @[ID.scala 54:38 ID.scala 54:38 ID.scala 72:25]
    reg_operandBsel <= mux(reset, UInt<1>("h0"), io_operandBsel_in) @[ID.scala 55:38 ID.scala 55:38 ID.scala 73:25]
    reg_hazard <= mux(reset, UInt<1>("h0"), io_hazard_in) @[ID.scala 56:33 ID.scala 56:33 ID.scala 74:20]
    reg_pc <= mux(reset, UInt<32>("h0"), io_pc_in) @[ID.scala 57:29 ID.scala 57:29 ID.scala 75:16]
    reg_pc4 <= mux(reset, UInt<32>("h0"), io_pc4_in) @[ID.scala 58:30 ID.scala 58:30 ID.scala 76:17]
