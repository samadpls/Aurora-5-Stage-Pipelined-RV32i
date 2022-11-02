circuit Top :
  module pccounter :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : UInt<32>
    output io_pc_4 : UInt<32>
    output io_pc_out : UInt<32>

    reg reg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg) @[pc_counter.scala 12:24]
    node _io_pc_4_T = add(reg, UInt<3>("h4")) @[pc_counter.scala 16:21]
    node _io_pc_4_T_1 = tail(_io_pc_4_T, 1) @[pc_counter.scala 16:21]
    io_pc_4 <= _io_pc_4_T_1 @[pc_counter.scala 16:16]
    io_pc_out <= reg @[pc_counter.scala 15:18]
    reg <= mux(reset, UInt<32>("h0"), io_addr) @[pc_counter.scala 12:24 pc_counter.scala 12:24 pc_counter.scala 14:12]

  module datamem :
    input clock : Clock
    input reset : UInt<1>
    input io_Addr : UInt<8>
    input io_Data : SInt<32>
    input io_MemWrite : UInt<1>
    input io_MemRead : UInt<1>
    output io_out : SInt<32>

    mem mem : @[datamem.scala 13:22]
      data-type => SInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_out_MPORT
      writer => MPORT
      read-under-write => undefined
    node _T = eq(io_MemWrite, UInt<1>("h1")) @[datamem.scala 14:27]
    node _GEN_0 = validif(_T, io_Addr) @[datamem.scala 14:35]
    node _GEN_1 = validif(_T, clock) @[datamem.scala 14:35]
    node _GEN_2 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[datamem.scala 14:35 datamem.scala 13:22]
    node _GEN_3 = validif(_T, UInt<1>("h1")) @[datamem.scala 14:35]
    node _GEN_4 = validif(_T, io_Data) @[datamem.scala 14:35]
    node _T_1 = eq(io_MemRead, UInt<1>("h1")) @[datamem.scala 17:25]
    node _GEN_5 = validif(_T_1, io_Addr) @[datamem.scala 17:33 datamem.scala 18:35]
    node _GEN_6 = validif(_T_1, clock) @[datamem.scala 17:33 datamem.scala 18:35]
    node _GEN_7 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[datamem.scala 17:33 datamem.scala 18:35 datamem.scala 13:22]
    node _GEN_8 = mux(_T_1, mem.io_out_MPORT.data, asSInt(UInt<1>("h0"))) @[datamem.scala 17:33 datamem.scala 18:24 datamem.scala 20:28]
    io_out <= _GEN_8
    mem.io_out_MPORT.addr <= _GEN_5
    mem.io_out_MPORT.en <= _GEN_7
    mem.io_out_MPORT.clk <= _GEN_6
    mem.MPORT.addr <= _GEN_0
    mem.MPORT.en <= _GEN_2
    mem.MPORT.clk <= _GEN_1
    mem.MPORT.data <= _GEN_4
    mem.MPORT.mask <= _GEN_3

  module InstMem :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : UInt<10>
    output io_inst : UInt<32>

    mem imem : @[instmem.scala 13:20]
      data-type => UInt<32>
      depth => 32
      read-latency => 0
      write-latency => 1
      reader => io_inst_MPORT
      read-under-write => undefined
    node _io_inst_T = bits(io_addr, 4, 0) @[instmem.scala 15:25]
    io_inst <= imem.io_inst_MPORT.data @[instmem.scala 15:13]
    imem.io_inst_MPORT.addr <= _io_inst_T @[instmem.scala 15:25]
    imem.io_inst_MPORT.en <= UInt<1>("h1") @[instmem.scala 15:25]
    imem.io_inst_MPORT.clk <= clock @[instmem.scala 15:25]

  module reg :
    input clock : Clock
    input reset : UInt<1>
    input io_write : UInt<1>
    input io_rs1 : UInt<5>
    input io_rs2 : UInt<5>
    input io_rd : UInt<5>
    input io_WriteData : SInt<32>
    output io_rd1 : SInt<32>
    output io_rd2 : SInt<32>

    reg register_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_0) @[regfile.scala 17:31]
    reg register_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_1) @[regfile.scala 17:31]
    reg register_2 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_2) @[regfile.scala 17:31]
    reg register_3 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_3) @[regfile.scala 17:31]
    reg register_4 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_4) @[regfile.scala 17:31]
    reg register_5 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_5) @[regfile.scala 17:31]
    reg register_6 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_6) @[regfile.scala 17:31]
    reg register_7 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_7) @[regfile.scala 17:31]
    reg register_8 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_8) @[regfile.scala 17:31]
    reg register_9 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_9) @[regfile.scala 17:31]
    reg register_10 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_10) @[regfile.scala 17:31]
    reg register_11 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_11) @[regfile.scala 17:31]
    reg register_12 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_12) @[regfile.scala 17:31]
    reg register_13 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_13) @[regfile.scala 17:31]
    reg register_14 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_14) @[regfile.scala 17:31]
    reg register_15 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_15) @[regfile.scala 17:31]
    reg register_16 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_16) @[regfile.scala 17:31]
    reg register_17 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_17) @[regfile.scala 17:31]
    reg register_18 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_18) @[regfile.scala 17:31]
    reg register_19 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_19) @[regfile.scala 17:31]
    reg register_20 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_20) @[regfile.scala 17:31]
    reg register_21 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_21) @[regfile.scala 17:31]
    reg register_22 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_22) @[regfile.scala 17:31]
    reg register_23 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_23) @[regfile.scala 17:31]
    reg register_24 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_24) @[regfile.scala 17:31]
    reg register_25 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_25) @[regfile.scala 17:31]
    reg register_26 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_26) @[regfile.scala 17:31]
    reg register_27 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_27) @[regfile.scala 17:31]
    reg register_28 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_28) @[regfile.scala 17:31]
    reg register_29 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_29) @[regfile.scala 17:31]
    reg register_30 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_30) @[regfile.scala 17:31]
    reg register_31 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), register_31) @[regfile.scala 17:31]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_rs1), register_0) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_rs1), register_1, _GEN_0) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_rs1), register_2, _GEN_1) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_rs1), register_3, _GEN_2) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_rs1), register_4, _GEN_3) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_rs1), register_5, _GEN_4) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_rs1), register_6, _GEN_5) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_rs1), register_7, _GEN_6) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_rs1), register_8, _GEN_7) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_rs1), register_9, _GEN_8) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_rs1), register_10, _GEN_9) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_rs1), register_11, _GEN_10) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_rs1), register_12, _GEN_11) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_rs1), register_13, _GEN_12) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_rs1), register_14, _GEN_13) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_rs1), register_15, _GEN_14) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_rs1), register_16, _GEN_15) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_rs1), register_17, _GEN_16) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_rs1), register_18, _GEN_17) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_rs1), register_19, _GEN_18) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_rs1), register_20, _GEN_19) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_rs1), register_21, _GEN_20) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_rs1), register_22, _GEN_21) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_rs1), register_23, _GEN_22) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_rs1), register_24, _GEN_23) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_rs1), register_25, _GEN_24) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_rs1), register_26, _GEN_25) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_rs1), register_27, _GEN_26) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_rs1), register_28, _GEN_27) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_rs1), register_29, _GEN_28) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_rs1), register_30, _GEN_29) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_rs1), register_31, _GEN_30) @[regfile.scala 21:16 regfile.scala 21:16]
    node _GEN_32 = validif(eq(UInt<1>("h0"), io_rs2), register_0) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_33 = mux(eq(UInt<1>("h1"), io_rs2), register_1, _GEN_32) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_34 = mux(eq(UInt<2>("h2"), io_rs2), register_2, _GEN_33) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_35 = mux(eq(UInt<2>("h3"), io_rs2), register_3, _GEN_34) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_36 = mux(eq(UInt<3>("h4"), io_rs2), register_4, _GEN_35) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_37 = mux(eq(UInt<3>("h5"), io_rs2), register_5, _GEN_36) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_38 = mux(eq(UInt<3>("h6"), io_rs2), register_6, _GEN_37) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_39 = mux(eq(UInt<3>("h7"), io_rs2), register_7, _GEN_38) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_40 = mux(eq(UInt<4>("h8"), io_rs2), register_8, _GEN_39) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_41 = mux(eq(UInt<4>("h9"), io_rs2), register_9, _GEN_40) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_42 = mux(eq(UInt<4>("ha"), io_rs2), register_10, _GEN_41) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_43 = mux(eq(UInt<4>("hb"), io_rs2), register_11, _GEN_42) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_44 = mux(eq(UInt<4>("hc"), io_rs2), register_12, _GEN_43) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_45 = mux(eq(UInt<4>("hd"), io_rs2), register_13, _GEN_44) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_46 = mux(eq(UInt<4>("he"), io_rs2), register_14, _GEN_45) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_47 = mux(eq(UInt<4>("hf"), io_rs2), register_15, _GEN_46) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_48 = mux(eq(UInt<5>("h10"), io_rs2), register_16, _GEN_47) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_49 = mux(eq(UInt<5>("h11"), io_rs2), register_17, _GEN_48) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_50 = mux(eq(UInt<5>("h12"), io_rs2), register_18, _GEN_49) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_51 = mux(eq(UInt<5>("h13"), io_rs2), register_19, _GEN_50) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_52 = mux(eq(UInt<5>("h14"), io_rs2), register_20, _GEN_51) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_53 = mux(eq(UInt<5>("h15"), io_rs2), register_21, _GEN_52) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_54 = mux(eq(UInt<5>("h16"), io_rs2), register_22, _GEN_53) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_55 = mux(eq(UInt<5>("h17"), io_rs2), register_23, _GEN_54) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_56 = mux(eq(UInt<5>("h18"), io_rs2), register_24, _GEN_55) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_57 = mux(eq(UInt<5>("h19"), io_rs2), register_25, _GEN_56) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_58 = mux(eq(UInt<5>("h1a"), io_rs2), register_26, _GEN_57) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_59 = mux(eq(UInt<5>("h1b"), io_rs2), register_27, _GEN_58) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_60 = mux(eq(UInt<5>("h1c"), io_rs2), register_28, _GEN_59) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_61 = mux(eq(UInt<5>("h1d"), io_rs2), register_29, _GEN_60) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_62 = mux(eq(UInt<5>("h1e"), io_rs2), register_30, _GEN_61) @[regfile.scala 22:16 regfile.scala 22:16]
    node _GEN_63 = mux(eq(UInt<5>("h1f"), io_rs2), register_31, _GEN_62) @[regfile.scala 22:16 regfile.scala 22:16]
    node _T = eq(io_write, UInt<1>("h1")) @[regfile.scala 24:23]
    node _T_1 = eq(io_rd, UInt<1>("h0")) @[regfile.scala 25:28]
    node _register_io_rd = pad(asSInt(UInt<1>("h0")), 32) @[regfile.scala 26:41 regfile.scala 26:41]
    node _GEN_64 = mux(eq(UInt<1>("h0"), io_rd), _register_io_rd, asSInt(UInt<1>("h0"))) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 18:21]
    node _GEN_65 = mux(eq(UInt<1>("h1"), io_rd), _register_io_rd, register_1) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_66 = mux(eq(UInt<2>("h2"), io_rd), _register_io_rd, register_2) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_67 = mux(eq(UInt<2>("h3"), io_rd), _register_io_rd, register_3) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_68 = mux(eq(UInt<3>("h4"), io_rd), _register_io_rd, register_4) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_69 = mux(eq(UInt<3>("h5"), io_rd), _register_io_rd, register_5) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_70 = mux(eq(UInt<3>("h6"), io_rd), _register_io_rd, register_6) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_71 = mux(eq(UInt<3>("h7"), io_rd), _register_io_rd, register_7) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_72 = mux(eq(UInt<4>("h8"), io_rd), _register_io_rd, register_8) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_73 = mux(eq(UInt<4>("h9"), io_rd), _register_io_rd, register_9) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_74 = mux(eq(UInt<4>("ha"), io_rd), _register_io_rd, register_10) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_75 = mux(eq(UInt<4>("hb"), io_rd), _register_io_rd, register_11) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_76 = mux(eq(UInt<4>("hc"), io_rd), _register_io_rd, register_12) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_77 = mux(eq(UInt<4>("hd"), io_rd), _register_io_rd, register_13) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_78 = mux(eq(UInt<4>("he"), io_rd), _register_io_rd, register_14) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_79 = mux(eq(UInt<4>("hf"), io_rd), _register_io_rd, register_15) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_80 = mux(eq(UInt<5>("h10"), io_rd), _register_io_rd, register_16) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_81 = mux(eq(UInt<5>("h11"), io_rd), _register_io_rd, register_17) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_82 = mux(eq(UInt<5>("h12"), io_rd), _register_io_rd, register_18) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_83 = mux(eq(UInt<5>("h13"), io_rd), _register_io_rd, register_19) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_84 = mux(eq(UInt<5>("h14"), io_rd), _register_io_rd, register_20) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_85 = mux(eq(UInt<5>("h15"), io_rd), _register_io_rd, register_21) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_86 = mux(eq(UInt<5>("h16"), io_rd), _register_io_rd, register_22) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_87 = mux(eq(UInt<5>("h17"), io_rd), _register_io_rd, register_23) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_88 = mux(eq(UInt<5>("h18"), io_rd), _register_io_rd, register_24) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_89 = mux(eq(UInt<5>("h19"), io_rd), _register_io_rd, register_25) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_90 = mux(eq(UInt<5>("h1a"), io_rd), _register_io_rd, register_26) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_91 = mux(eq(UInt<5>("h1b"), io_rd), _register_io_rd, register_27) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_92 = mux(eq(UInt<5>("h1c"), io_rd), _register_io_rd, register_28) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_93 = mux(eq(UInt<5>("h1d"), io_rd), _register_io_rd, register_29) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_94 = mux(eq(UInt<5>("h1e"), io_rd), _register_io_rd, register_30) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _GEN_95 = mux(eq(UInt<5>("h1f"), io_rd), _register_io_rd, register_31) @[regfile.scala 26:41 regfile.scala 26:41 regfile.scala 17:31]
    node _register_io_rd_0 = io_WriteData @[regfile.scala 28:41 regfile.scala 28:41]
    node _GEN_96 = mux(eq(UInt<1>("h0"), io_rd), _register_io_rd_0, asSInt(UInt<1>("h0"))) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 18:21]
    node _GEN_97 = mux(eq(UInt<1>("h1"), io_rd), _register_io_rd_0, register_1) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_98 = mux(eq(UInt<2>("h2"), io_rd), _register_io_rd_0, register_2) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_99 = mux(eq(UInt<2>("h3"), io_rd), _register_io_rd_0, register_3) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_100 = mux(eq(UInt<3>("h4"), io_rd), _register_io_rd_0, register_4) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_101 = mux(eq(UInt<3>("h5"), io_rd), _register_io_rd_0, register_5) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_102 = mux(eq(UInt<3>("h6"), io_rd), _register_io_rd_0, register_6) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_103 = mux(eq(UInt<3>("h7"), io_rd), _register_io_rd_0, register_7) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_104 = mux(eq(UInt<4>("h8"), io_rd), _register_io_rd_0, register_8) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_105 = mux(eq(UInt<4>("h9"), io_rd), _register_io_rd_0, register_9) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_106 = mux(eq(UInt<4>("ha"), io_rd), _register_io_rd_0, register_10) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_107 = mux(eq(UInt<4>("hb"), io_rd), _register_io_rd_0, register_11) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_108 = mux(eq(UInt<4>("hc"), io_rd), _register_io_rd_0, register_12) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_109 = mux(eq(UInt<4>("hd"), io_rd), _register_io_rd_0, register_13) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_110 = mux(eq(UInt<4>("he"), io_rd), _register_io_rd_0, register_14) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_111 = mux(eq(UInt<4>("hf"), io_rd), _register_io_rd_0, register_15) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_112 = mux(eq(UInt<5>("h10"), io_rd), _register_io_rd_0, register_16) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_113 = mux(eq(UInt<5>("h11"), io_rd), _register_io_rd_0, register_17) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_114 = mux(eq(UInt<5>("h12"), io_rd), _register_io_rd_0, register_18) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_115 = mux(eq(UInt<5>("h13"), io_rd), _register_io_rd_0, register_19) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_116 = mux(eq(UInt<5>("h14"), io_rd), _register_io_rd_0, register_20) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_117 = mux(eq(UInt<5>("h15"), io_rd), _register_io_rd_0, register_21) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_118 = mux(eq(UInt<5>("h16"), io_rd), _register_io_rd_0, register_22) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_119 = mux(eq(UInt<5>("h17"), io_rd), _register_io_rd_0, register_23) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_120 = mux(eq(UInt<5>("h18"), io_rd), _register_io_rd_0, register_24) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_121 = mux(eq(UInt<5>("h19"), io_rd), _register_io_rd_0, register_25) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_122 = mux(eq(UInt<5>("h1a"), io_rd), _register_io_rd_0, register_26) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_123 = mux(eq(UInt<5>("h1b"), io_rd), _register_io_rd_0, register_27) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_124 = mux(eq(UInt<5>("h1c"), io_rd), _register_io_rd_0, register_28) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_125 = mux(eq(UInt<5>("h1d"), io_rd), _register_io_rd_0, register_29) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_126 = mux(eq(UInt<5>("h1e"), io_rd), _register_io_rd_0, register_30) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_127 = mux(eq(UInt<5>("h1f"), io_rd), _register_io_rd_0, register_31) @[regfile.scala 28:41 regfile.scala 28:41 regfile.scala 17:31]
    node _GEN_128 = mux(_T_1, _GEN_64, _GEN_96) @[regfile.scala 25:43]
    node _GEN_129 = mux(_T_1, _GEN_65, _GEN_97) @[regfile.scala 25:43]
    node _GEN_130 = mux(_T_1, _GEN_66, _GEN_98) @[regfile.scala 25:43]
    node _GEN_131 = mux(_T_1, _GEN_67, _GEN_99) @[regfile.scala 25:43]
    node _GEN_132 = mux(_T_1, _GEN_68, _GEN_100) @[regfile.scala 25:43]
    node _GEN_133 = mux(_T_1, _GEN_69, _GEN_101) @[regfile.scala 25:43]
    node _GEN_134 = mux(_T_1, _GEN_70, _GEN_102) @[regfile.scala 25:43]
    node _GEN_135 = mux(_T_1, _GEN_71, _GEN_103) @[regfile.scala 25:43]
    node _GEN_136 = mux(_T_1, _GEN_72, _GEN_104) @[regfile.scala 25:43]
    node _GEN_137 = mux(_T_1, _GEN_73, _GEN_105) @[regfile.scala 25:43]
    node _GEN_138 = mux(_T_1, _GEN_74, _GEN_106) @[regfile.scala 25:43]
    node _GEN_139 = mux(_T_1, _GEN_75, _GEN_107) @[regfile.scala 25:43]
    node _GEN_140 = mux(_T_1, _GEN_76, _GEN_108) @[regfile.scala 25:43]
    node _GEN_141 = mux(_T_1, _GEN_77, _GEN_109) @[regfile.scala 25:43]
    node _GEN_142 = mux(_T_1, _GEN_78, _GEN_110) @[regfile.scala 25:43]
    node _GEN_143 = mux(_T_1, _GEN_79, _GEN_111) @[regfile.scala 25:43]
    node _GEN_144 = mux(_T_1, _GEN_80, _GEN_112) @[regfile.scala 25:43]
    node _GEN_145 = mux(_T_1, _GEN_81, _GEN_113) @[regfile.scala 25:43]
    node _GEN_146 = mux(_T_1, _GEN_82, _GEN_114) @[regfile.scala 25:43]
    node _GEN_147 = mux(_T_1, _GEN_83, _GEN_115) @[regfile.scala 25:43]
    node _GEN_148 = mux(_T_1, _GEN_84, _GEN_116) @[regfile.scala 25:43]
    node _GEN_149 = mux(_T_1, _GEN_85, _GEN_117) @[regfile.scala 25:43]
    node _GEN_150 = mux(_T_1, _GEN_86, _GEN_118) @[regfile.scala 25:43]
    node _GEN_151 = mux(_T_1, _GEN_87, _GEN_119) @[regfile.scala 25:43]
    node _GEN_152 = mux(_T_1, _GEN_88, _GEN_120) @[regfile.scala 25:43]
    node _GEN_153 = mux(_T_1, _GEN_89, _GEN_121) @[regfile.scala 25:43]
    node _GEN_154 = mux(_T_1, _GEN_90, _GEN_122) @[regfile.scala 25:43]
    node _GEN_155 = mux(_T_1, _GEN_91, _GEN_123) @[regfile.scala 25:43]
    node _GEN_156 = mux(_T_1, _GEN_92, _GEN_124) @[regfile.scala 25:43]
    node _GEN_157 = mux(_T_1, _GEN_93, _GEN_125) @[regfile.scala 25:43]
    node _GEN_158 = mux(_T_1, _GEN_94, _GEN_126) @[regfile.scala 25:43]
    node _GEN_159 = mux(_T_1, _GEN_95, _GEN_127) @[regfile.scala 25:43]
    node _GEN_160 = mux(_T, _GEN_128, asSInt(UInt<1>("h0"))) @[regfile.scala 24:31 regfile.scala 18:21]
    node _GEN_161 = mux(_T, _GEN_129, register_1) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_162 = mux(_T, _GEN_130, register_2) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_163 = mux(_T, _GEN_131, register_3) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_164 = mux(_T, _GEN_132, register_4) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_165 = mux(_T, _GEN_133, register_5) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_166 = mux(_T, _GEN_134, register_6) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_167 = mux(_T, _GEN_135, register_7) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_168 = mux(_T, _GEN_136, register_8) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_169 = mux(_T, _GEN_137, register_9) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_170 = mux(_T, _GEN_138, register_10) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_171 = mux(_T, _GEN_139, register_11) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_172 = mux(_T, _GEN_140, register_12) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_173 = mux(_T, _GEN_141, register_13) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_174 = mux(_T, _GEN_142, register_14) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_175 = mux(_T, _GEN_143, register_15) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_176 = mux(_T, _GEN_144, register_16) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_177 = mux(_T, _GEN_145, register_17) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_178 = mux(_T, _GEN_146, register_18) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_179 = mux(_T, _GEN_147, register_19) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_180 = mux(_T, _GEN_148, register_20) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_181 = mux(_T, _GEN_149, register_21) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_182 = mux(_T, _GEN_150, register_22) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_183 = mux(_T, _GEN_151, register_23) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_184 = mux(_T, _GEN_152, register_24) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_185 = mux(_T, _GEN_153, register_25) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_186 = mux(_T, _GEN_154, register_26) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_187 = mux(_T, _GEN_155, register_27) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_188 = mux(_T, _GEN_156, register_28) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_189 = mux(_T, _GEN_157, register_29) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_190 = mux(_T, _GEN_158, register_30) @[regfile.scala 24:31 regfile.scala 17:31]
    node _GEN_191 = mux(_T, _GEN_159, register_31) @[regfile.scala 24:31 regfile.scala 17:31]
    node _register_WIRE_0 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_1 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_2 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_3 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_4 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_5 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_6 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_7 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_8 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_9 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_10 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_11 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_12 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_13 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_14 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_15 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_16 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_17 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_18 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_19 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_20 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_21 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_22 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_23 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_24 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_25 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_26 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_27 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_28 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_29 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_30 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_WIRE_31 = asSInt(UInt<32>("h0")) @[regfile.scala 17:39 regfile.scala 17:39]
    node _register_io_rs1 = _GEN_31 @[regfile.scala 21:16]
    node _register_io_rs2 = _GEN_63 @[regfile.scala 22:16]
    io_rd1 <= _register_io_rs1 @[regfile.scala 21:16]
    io_rd2 <= _register_io_rs2 @[regfile.scala 22:16]
    register_0 <= mux(reset, _register_WIRE_0, _GEN_160) @[regfile.scala 17:31 regfile.scala 17:31]
    register_1 <= mux(reset, _register_WIRE_1, _GEN_161) @[regfile.scala 17:31 regfile.scala 17:31]
    register_2 <= mux(reset, _register_WIRE_2, _GEN_162) @[regfile.scala 17:31 regfile.scala 17:31]
    register_3 <= mux(reset, _register_WIRE_3, _GEN_163) @[regfile.scala 17:31 regfile.scala 17:31]
    register_4 <= mux(reset, _register_WIRE_4, _GEN_164) @[regfile.scala 17:31 regfile.scala 17:31]
    register_5 <= mux(reset, _register_WIRE_5, _GEN_165) @[regfile.scala 17:31 regfile.scala 17:31]
    register_6 <= mux(reset, _register_WIRE_6, _GEN_166) @[regfile.scala 17:31 regfile.scala 17:31]
    register_7 <= mux(reset, _register_WIRE_7, _GEN_167) @[regfile.scala 17:31 regfile.scala 17:31]
    register_8 <= mux(reset, _register_WIRE_8, _GEN_168) @[regfile.scala 17:31 regfile.scala 17:31]
    register_9 <= mux(reset, _register_WIRE_9, _GEN_169) @[regfile.scala 17:31 regfile.scala 17:31]
    register_10 <= mux(reset, _register_WIRE_10, _GEN_170) @[regfile.scala 17:31 regfile.scala 17:31]
    register_11 <= mux(reset, _register_WIRE_11, _GEN_171) @[regfile.scala 17:31 regfile.scala 17:31]
    register_12 <= mux(reset, _register_WIRE_12, _GEN_172) @[regfile.scala 17:31 regfile.scala 17:31]
    register_13 <= mux(reset, _register_WIRE_13, _GEN_173) @[regfile.scala 17:31 regfile.scala 17:31]
    register_14 <= mux(reset, _register_WIRE_14, _GEN_174) @[regfile.scala 17:31 regfile.scala 17:31]
    register_15 <= mux(reset, _register_WIRE_15, _GEN_175) @[regfile.scala 17:31 regfile.scala 17:31]
    register_16 <= mux(reset, _register_WIRE_16, _GEN_176) @[regfile.scala 17:31 regfile.scala 17:31]
    register_17 <= mux(reset, _register_WIRE_17, _GEN_177) @[regfile.scala 17:31 regfile.scala 17:31]
    register_18 <= mux(reset, _register_WIRE_18, _GEN_178) @[regfile.scala 17:31 regfile.scala 17:31]
    register_19 <= mux(reset, _register_WIRE_19, _GEN_179) @[regfile.scala 17:31 regfile.scala 17:31]
    register_20 <= mux(reset, _register_WIRE_20, _GEN_180) @[regfile.scala 17:31 regfile.scala 17:31]
    register_21 <= mux(reset, _register_WIRE_21, _GEN_181) @[regfile.scala 17:31 regfile.scala 17:31]
    register_22 <= mux(reset, _register_WIRE_22, _GEN_182) @[regfile.scala 17:31 regfile.scala 17:31]
    register_23 <= mux(reset, _register_WIRE_23, _GEN_183) @[regfile.scala 17:31 regfile.scala 17:31]
    register_24 <= mux(reset, _register_WIRE_24, _GEN_184) @[regfile.scala 17:31 regfile.scala 17:31]
    register_25 <= mux(reset, _register_WIRE_25, _GEN_185) @[regfile.scala 17:31 regfile.scala 17:31]
    register_26 <= mux(reset, _register_WIRE_26, _GEN_186) @[regfile.scala 17:31 regfile.scala 17:31]
    register_27 <= mux(reset, _register_WIRE_27, _GEN_187) @[regfile.scala 17:31 regfile.scala 17:31]
    register_28 <= mux(reset, _register_WIRE_28, _GEN_188) @[regfile.scala 17:31 regfile.scala 17:31]
    register_29 <= mux(reset, _register_WIRE_29, _GEN_189) @[regfile.scala 17:31 regfile.scala 17:31]
    register_30 <= mux(reset, _register_WIRE_30, _GEN_190) @[regfile.scala 17:31 regfile.scala 17:31]
    register_31 <= mux(reset, _register_WIRE_31, _GEN_191) @[regfile.scala 17:31 regfile.scala 17:31]

  module controler :
    input clock : Clock
    input reset : UInt<1>
    input io_opcod : UInt<7>
    output io_memwrite : UInt<1>
    output io_branch : UInt<1>
    output io_memread : UInt<1>
    output io_regwrite : UInt<1>
    output io_memtoreg : UInt<1>
    output io_aluop : UInt<3>
    output io_op_a : UInt<2>
    output io_op_b : UInt<1>
    output io_extend_sel : UInt<2>
    output io_next_pc : UInt<2>

    node _T = eq(UInt<5>("h13"), io_opcod) @[Conditional.scala 37:30]
    node _T_1 = eq(UInt<2>("h3"), io_opcod) @[Conditional.scala 37:30]
    node _T_2 = eq(UInt<7>("h6f"), io_opcod) @[Conditional.scala 37:30]
    node _T_3 = eq(UInt<7>("h67"), io_opcod) @[Conditional.scala 37:30]
    node _T_4 = eq(UInt<6>("h33"), io_opcod) @[Conditional.scala 37:30]
    node _T_5 = eq(UInt<6>("h23"), io_opcod) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<7>("h63"), io_opcod) @[Conditional.scala 37:30]
    node _T_7 = eq(UInt<6>("h37"), io_opcod) @[Conditional.scala 37:30]
    node _GEN_0 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[Conditional.scala 39:67 controler.scala 123:24 controler.scala 25:20]
    node _GEN_1 = mux(_T_7, UInt<3>("h6"), UInt<1>("h0")) @[Conditional.scala 39:67 controler.scala 124:21 controler.scala 27:17]
    node _GEN_2 = mux(_T_7, UInt<2>("h2"), UInt<1>("h0")) @[Conditional.scala 39:67 controler.scala 125:20 controler.scala 28:16]
    node _GEN_3 = mux(_T_7, UInt<1>("h0"), UInt<1>("h0")) @[Conditional.scala 39:67 controler.scala 127:23 controler.scala 31:19]
    node _GEN_4 = mux(_T_6, UInt<1>("h1"), _GEN_3) @[Conditional.scala 39:67 controler.scala 110:22]
    node _GEN_5 = mux(_T_6, UInt<2>("h2"), _GEN_1) @[Conditional.scala 39:67 controler.scala 111:21]
    node _GEN_6 = mux(_T_6, UInt<1>("h0"), _GEN_3) @[Conditional.scala 39:67 controler.scala 113:24]
    node _GEN_7 = mux(_T_6, UInt<1>("h0"), _GEN_0) @[Conditional.scala 39:67 controler.scala 115:24]
    node _GEN_8 = mux(_T_6, UInt<1>("h0"), _GEN_2) @[Conditional.scala 39:67 controler.scala 117:20]
    node _GEN_9 = mux(_T_5, UInt<1>("h0"), _GEN_6) @[Conditional.scala 39:67 controler.scala 101:24]
    node _GEN_10 = mux(_T_5, UInt<1>("h1"), _GEN_7) @[Conditional.scala 39:67 controler.scala 97:24]
    node _GEN_11 = mux(_T_5, UInt<3>("h5"), _GEN_5) @[Conditional.scala 39:67 controler.scala 98:21]
    node _GEN_12 = mux(_T_5, UInt<1>("h1"), _GEN_8) @[Conditional.scala 39:67 controler.scala 100:26]
    node _GEN_13 = mux(_T_5, UInt<1>("h0"), _GEN_4) @[Conditional.scala 39:67 controler.scala 102:22]
    node _GEN_14 = mux(_T_5, UInt<1>("h0"), _GEN_8) @[Conditional.scala 39:67 controler.scala 105:20]
    node _GEN_15 = mux(_T_4, UInt<1>("h1"), _GEN_10) @[Conditional.scala 39:67 controler.scala 84:24]
    node _GEN_16 = mux(_T_4, UInt<1>("h0"), _GEN_9) @[Conditional.scala 39:67 controler.scala 85:24]
    node _GEN_17 = mux(_T_4, UInt<1>("h0"), _GEN_13) @[Conditional.scala 39:67 controler.scala 86:22]
    node _GEN_18 = mux(_T_4, UInt<1>("h0"), _GEN_11) @[Conditional.scala 39:67 controler.scala 89:21]
    node _GEN_19 = mux(_T_4, UInt<1>("h0"), _GEN_14) @[Conditional.scala 39:67 controler.scala 90:20]
    node _GEN_20 = mux(_T_4, UInt<1>("h0"), _GEN_10) @[Conditional.scala 39:67 controler.scala 91:20]
    node _GEN_21 = mux(_T_4, UInt<1>("h0"), _GEN_12) @[Conditional.scala 39:67 controler.scala 92:26]
    node _GEN_22 = mux(_T_3, UInt<1>("h1"), _GEN_15) @[Conditional.scala 39:67 controler.scala 71:24]
    node _GEN_23 = mux(_T_3, UInt<2>("h3"), _GEN_18) @[Conditional.scala 39:67 controler.scala 72:21]
    node _GEN_24 = mux(_T_3, UInt<1>("h1"), _GEN_19) @[Conditional.scala 39:67 controler.scala 73:20]
    node _GEN_25 = mux(_T_3, UInt<1>("h1"), _GEN_20) @[Conditional.scala 39:67 controler.scala 74:20]
    node _GEN_26 = mux(_T_3, UInt<2>("h3"), _GEN_17) @[Conditional.scala 39:67 controler.scala 75:23]
    node _GEN_27 = mux(_T_3, UInt<1>("h0"), _GEN_16) @[Conditional.scala 39:67 controler.scala 76:24]
    node _GEN_28 = mux(_T_3, UInt<1>("h0"), _GEN_17) @[Conditional.scala 39:67 controler.scala 77:22]
    node _GEN_29 = mux(_T_3, UInt<1>("h0"), _GEN_21) @[Conditional.scala 39:67 controler.scala 80:26]
    node _GEN_30 = mux(_T_2, UInt<1>("h1"), _GEN_22) @[Conditional.scala 39:67 controler.scala 58:24]
    node _GEN_31 = mux(_T_2, UInt<2>("h3"), _GEN_23) @[Conditional.scala 39:67 controler.scala 59:21]
    node _GEN_32 = mux(_T_2, UInt<1>("h1"), _GEN_24) @[Conditional.scala 39:67 controler.scala 60:20]
    node _GEN_33 = mux(_T_2, UInt<2>("h2"), _GEN_26) @[Conditional.scala 39:67 controler.scala 61:23]
    node _GEN_34 = mux(_T_2, UInt<1>("h0"), _GEN_27) @[Conditional.scala 39:67 controler.scala 62:24]
    node _GEN_35 = mux(_T_2, UInt<1>("h0"), _GEN_28) @[Conditional.scala 39:67 controler.scala 63:22]
    node _GEN_36 = mux(_T_2, UInt<1>("h0"), _GEN_25) @[Conditional.scala 39:67 controler.scala 66:20]
    node _GEN_37 = mux(_T_2, UInt<1>("h0"), _GEN_29) @[Conditional.scala 39:67 controler.scala 67:26]
    node _GEN_38 = mux(_T_1, UInt<1>("h1"), _GEN_30) @[Conditional.scala 39:67 controler.scala 46:24]
    node _GEN_39 = mux(_T_1, UInt<1>("h1"), _GEN_34) @[Conditional.scala 39:67 controler.scala 47:23]
    node _GEN_40 = mux(_T_1, UInt<3>("h4"), _GEN_31) @[Conditional.scala 39:67 controler.scala 49:21]
    node _GEN_41 = mux(_T_1, UInt<1>("h1"), _GEN_36) @[Conditional.scala 39:67 controler.scala 50:20]
    node _GEN_42 = mux(_T_1, UInt<1>("h0"), _GEN_34) @[Conditional.scala 39:67 controler.scala 51:24]
    node _GEN_43 = mux(_T_1, UInt<1>("h0"), _GEN_35) @[Conditional.scala 39:67 controler.scala 52:22]
    node _GEN_44 = mux(_T_1, UInt<1>("h0"), _GEN_32) @[Conditional.scala 39:67 controler.scala 53:20]
    node _GEN_45 = mux(_T_1, UInt<1>("h0"), _GEN_37) @[Conditional.scala 39:67 controler.scala 54:26]
    node _GEN_46 = mux(_T_1, UInt<1>("h0"), _GEN_33) @[Conditional.scala 39:67 controler.scala 55:23]
    node _GEN_47 = mux(_T, UInt<1>("h1"), _GEN_38) @[Conditional.scala 40:58 controler.scala 34:20]
    node _GEN_48 = mux(_T, UInt<1>("h1"), _GEN_40) @[Conditional.scala 40:58 controler.scala 35:17]
    node _GEN_49 = mux(_T, UInt<1>("h1"), _GEN_41) @[Conditional.scala 40:58 controler.scala 36:16]
    node _GEN_50 = mux(_T, UInt<1>("h0"), _GEN_42) @[Conditional.scala 40:58 controler.scala 37:20]
    node _GEN_51 = mux(_T, UInt<1>("h0"), _GEN_43) @[Conditional.scala 40:58 controler.scala 38:18]
    node _GEN_52 = mux(_T, UInt<1>("h0"), _GEN_39) @[Conditional.scala 40:58 controler.scala 39:20]
    node _GEN_53 = mux(_T, UInt<1>("h0"), _GEN_44) @[Conditional.scala 40:58 controler.scala 41:16]
    node _GEN_54 = mux(_T, UInt<1>("h0"), _GEN_45) @[Conditional.scala 40:58 controler.scala 42:22]
    node _GEN_55 = mux(_T, UInt<1>("h0"), _GEN_46) @[Conditional.scala 40:58 controler.scala 43:19]
    io_memwrite <= _GEN_50
    io_branch <= _GEN_51
    io_memread <= _GEN_52
    io_regwrite <= _GEN_47
    io_memtoreg <= _GEN_52
    io_aluop <= _GEN_48
    io_op_a <= _GEN_53
    io_op_b <= _GEN_49
    io_extend_sel <= _GEN_54
    io_next_pc <= _GEN_55

  module ALU4 :
    input clock : Clock
    input reset : UInt<1>
    input io_alu_Op : UInt<5>
    input io_in1 : SInt<32>
    input io_in2 : SInt<32>
    output io_out : SInt<32>

    node _T = eq(UInt<1>("h0"), io_alu_Op) @[Conditional.scala 37:30]
    node _io_out_T = add(io_in1, io_in2) @[alu.scala 17:39]
    node _io_out_T_1 = tail(_io_out_T, 1) @[alu.scala 17:39]
    node _io_out_T_2 = asSInt(_io_out_T_1) @[alu.scala 17:39]
    node _T_1 = eq(UInt<1>("h1"), io_alu_Op) @[Conditional.scala 37:30]
    node _io_out_T_3 = bits(io_in2, 4, 0) @[alu.scala 18:46]
    node _io_out_T_4 = dshl(io_in1, _io_out_T_3) @[alu.scala 18:38]
    node _T_2 = eq(UInt<2>("h2"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_3 = lt(io_in1, io_in2) @[alu.scala 20:24]
    node _GEN_0 = mux(_T_3, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[alu.scala 21:13 alu.scala 21:20 alu.scala 22:23]
    node _T_4 = eq(UInt<2>("h3"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_5 = asUInt(io_in1) @[alu.scala 24:25]
    node _T_6 = asUInt(io_in2) @[alu.scala 24:39]
    node _T_7 = lt(_T_5, _T_6) @[alu.scala 24:31]
    node _GEN_1 = mux(_T_7, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[alu.scala 24:46 alu.scala 24:53 alu.scala 24:76]
    node _T_8 = eq(UInt<5>("h16"), io_alu_Op) @[Conditional.scala 37:30]
    node _T_9 = asUInt(io_in1) @[alu.scala 27:25]
    node _T_10 = asUInt(io_in2) @[alu.scala 27:39]
    node _T_11 = lt(_T_9, _T_10) @[alu.scala 27:31]
    node _GEN_2 = mux(_T_11, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[alu.scala 27:46 alu.scala 27:53 alu.scala 27:76]
    node _T_12 = eq(UInt<3>("h4"), io_alu_Op) @[Conditional.scala 37:30]
    node _io_out_T_5 = xor(io_in1, io_in2) @[alu.scala 29:39]
    node _io_out_T_6 = asSInt(_io_out_T_5) @[alu.scala 29:39]
    node _T_13 = eq(UInt<3>("h5"), io_alu_Op) @[Conditional.scala 37:30]
    node _io_out_T_7 = asUInt(io_in1) @[alu.scala 30:40]
    node _io_out_T_8 = bits(io_in2, 4, 0) @[alu.scala 30:54]
    node _io_out_T_9 = dshr(_io_out_T_7, _io_out_T_8) @[alu.scala 30:46]
    node _io_out_T_10 = asSInt(_io_out_T_9) @[alu.scala 30:68]
    node _T_14 = eq(UInt<3>("h6"), io_alu_Op) @[Conditional.scala 37:30]
    node _io_out_T_11 = or(io_in1, io_in2) @[alu.scala 31:38]
    node _io_out_T_12 = asSInt(_io_out_T_11) @[alu.scala 31:38]
    node _T_15 = eq(UInt<3>("h7"), io_alu_Op) @[Conditional.scala 37:30]
    node _io_out_T_13 = and(io_in1, io_in2) @[alu.scala 32:39]
    node _io_out_T_14 = asSInt(_io_out_T_13) @[alu.scala 32:39]
    node _T_16 = eq(UInt<4>("h8"), io_alu_Op) @[Conditional.scala 37:30]
    node _io_out_T_15 = sub(io_in1, io_in2) @[alu.scala 33:39]
    node _io_out_T_16 = tail(_io_out_T_15, 1) @[alu.scala 33:39]
    node _io_out_T_17 = asSInt(_io_out_T_16) @[alu.scala 33:39]
    node _T_17 = eq(UInt<4>("hd"), io_alu_Op) @[Conditional.scala 37:30]
    node _io_out_T_18 = asUInt(io_in1) @[alu.scala 34:40]
    node _io_out_T_19 = bits(io_in2, 4, 0) @[alu.scala 34:54]
    node _io_out_T_20 = dshr(_io_out_T_18, _io_out_T_19) @[alu.scala 34:46]
    node _io_out_T_21 = asSInt(_io_out_T_20) @[alu.scala 34:68]
    node _T_18 = eq(UInt<5>("h1f"), io_alu_Op) @[Conditional.scala 37:30]
    node _GEN_3 = mux(_T_18, io_in1, asSInt(UInt<1>("h0"))) @[Conditional.scala 39:67 alu.scala 35:30 alu.scala 15:11]
    node _GEN_4 = mux(_T_17, _io_out_T_21, _GEN_3) @[Conditional.scala 39:67 alu.scala 34:30]
    node _GEN_5 = mux(_T_16, _io_out_T_17, _GEN_4) @[Conditional.scala 39:67 alu.scala 33:30]
    node _GEN_6 = mux(_T_15, _io_out_T_14, _GEN_5) @[Conditional.scala 39:67 alu.scala 32:30]
    node _GEN_7 = mux(_T_14, _io_out_T_12, _GEN_6) @[Conditional.scala 39:67 alu.scala 31:30]
    node _GEN_8 = mux(_T_13, _io_out_T_10, _GEN_7) @[Conditional.scala 39:67 alu.scala 30:30]
    node _GEN_9 = mux(_T_12, _io_out_T_6, _GEN_8) @[Conditional.scala 39:67 alu.scala 29:30]
    node _GEN_10 = mux(_T_8, _GEN_2, _GEN_9) @[Conditional.scala 39:67]
    node _GEN_11 = mux(_T_4, _GEN_1, _GEN_10) @[Conditional.scala 39:67]
    node _GEN_12 = mux(_T_2, _GEN_0, _GEN_11) @[Conditional.scala 39:67]
    node _GEN_13 = mux(_T_1, _io_out_T_4, _GEN_12) @[Conditional.scala 39:67 alu.scala 18:30]
    node _GEN_14 = mux(_T, _io_out_T_2, _GEN_13) @[Conditional.scala 40:58 alu.scala 17:31]
    io_out <= asSInt(bits(_GEN_14, 31, 0))

  module BranchControl :
    input clock : Clock
    input reset : UInt<1>
    input io_alu_opp : UInt<5>
    input io_branch : UInt<1>
    input io_arg_x : SInt<32>
    input io_arg_y : SInt<32>
    output io_br_taken : UInt<1>

    node _T = eq(UInt<5>("h10"), io_alu_opp) @[Conditional.scala 37:30]
    node _xy_T = eq(io_arg_x, io_arg_y) @[branch.scala 17:33]
    node _T_1 = eq(UInt<5>("h13"), io_alu_opp) @[Conditional.scala 37:30]
    node _xy_T_1 = neq(io_arg_x, io_arg_y) @[branch.scala 18:33]
    node _T_2 = eq(UInt<5>("h14"), io_alu_opp) @[Conditional.scala 37:30]
    node _xy_T_2 = lt(io_arg_x, io_arg_y) @[branch.scala 19:32]
    node _T_3 = eq(UInt<5>("h15"), io_alu_opp) @[Conditional.scala 37:30]
    node _xy_T_3 = gt(io_arg_x, io_arg_y) @[branch.scala 20:32]
    node _T_4 = eq(UInt<5>("h16"), io_alu_opp) @[Conditional.scala 37:30]
    node _xy_T_4 = lt(io_arg_x, io_arg_y) @[branch.scala 21:32]
    node _T_5 = eq(UInt<5>("h17"), io_alu_opp) @[Conditional.scala 37:30]
    node _xy_T_5 = geq(io_arg_x, io_arg_y) @[branch.scala 22:32]
    node _GEN_0 = mux(_T_5, _xy_T_5, UInt<1>("h0")) @[Conditional.scala 39:67 branch.scala 22:22 branch.scala 14:7]
    node _GEN_1 = mux(_T_4, _xy_T_4, _GEN_0) @[Conditional.scala 39:67 branch.scala 21:22]
    node _GEN_2 = mux(_T_3, _xy_T_3, _GEN_1) @[Conditional.scala 39:67 branch.scala 20:22]
    node _GEN_3 = mux(_T_2, _xy_T_2, _GEN_2) @[Conditional.scala 39:67 branch.scala 19:22]
    node _GEN_4 = mux(_T_1, _xy_T_1, _GEN_3) @[Conditional.scala 39:67 branch.scala 18:22]
    node _GEN_5 = mux(_T, _xy_T, _GEN_4) @[Conditional.scala 40:58 branch.scala 17:22]
    node xy = _GEN_5 @[branch.scala 13:16]
    node _io_br_taken_T = and(xy, io_branch) @[branch.scala 24:17]
    io_br_taken <= _io_br_taken_T @[branch.scala 24:12]

  module ImmdValGen1 :
    input clock : Clock
    input reset : UInt<1>
    input io_instr : UInt<32>
    input io_pc_val : UInt<32>
    output io_s_imm : SInt<32>
    output io_sb_imm : SInt<32>
    output io_uj_imm : SInt<32>
    output io_u_imm : SInt<32>
    output io_i_imm : SInt<32>

    node s_imm13_hi = bits(io_instr, 31, 25) @[imme.scala 21:36]
    node s_imm13_lo = bits(io_instr, 11, 7) @[imme.scala 21:52]
    node s_imm13 = cat(s_imm13_hi, s_imm13_lo) @[Cat.scala 30:58]
    node _io_s_imm_T = bits(s_imm13, 11, 11) @[imme.scala 22:41]
    node _io_s_imm_T_1 = bits(_io_s_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node io_s_imm_hi = mux(_io_s_imm_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 72:12]
    node _io_s_imm_T_2 = cat(io_s_imm_hi, s_imm13) @[Cat.scala 30:58]
    node _io_s_imm_T_3 = asSInt(_io_s_imm_T_2) @[imme.scala 22:57]
    node sb_imm13_hi_hi_hi = bits(io_instr, 31, 31) @[imme.scala 24:37]
    node sb_imm13_hi_hi_lo = bits(io_instr, 7, 7) @[imme.scala 24:50]
    node sb_imm13_hi_lo = bits(io_instr, 30, 25) @[imme.scala 24:62]
    node sb_imm13_lo_hi = bits(io_instr, 11, 8) @[imme.scala 24:78]
    node sb_imm13_lo = cat(sb_imm13_lo_hi, UInt<1>("h0")) @[Cat.scala 30:58]
    node sb_imm13_hi_hi = cat(sb_imm13_hi_hi_hi, sb_imm13_hi_hi_lo) @[Cat.scala 30:58]
    node sb_imm13_hi = cat(sb_imm13_hi_hi, sb_imm13_hi_lo) @[Cat.scala 30:58]
    node sb_imm13 = cat(sb_imm13_hi, sb_imm13_lo) @[Cat.scala 30:58]
    node _io_sb_imm_T = bits(sb_imm13, 12, 12) @[imme.scala 25:44]
    node _io_sb_imm_T_1 = bits(_io_sb_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node io_sb_imm_hi = mux(_io_sb_imm_T_1, UInt<19>("h7ffff"), UInt<19>("h0")) @[Bitwise.scala 72:12]
    node _io_sb_imm_T_2 = cat(io_sb_imm_hi, sb_imm13) @[Cat.scala 30:58]
    node _io_sb_imm_T_3 = add(_io_sb_imm_T_2, io_pc_val) @[imme.scala 25:61]
    node _io_sb_imm_T_4 = tail(_io_sb_imm_T_3, 1) @[imme.scala 25:61]
    node _io_sb_imm_T_5 = asSInt(_io_sb_imm_T_4) @[imme.scala 25:74]
    node uj_imm21_hi_hi_hi = bits(io_instr, 31, 31) @[imme.scala 27:37]
    node uj_imm21_hi_hi_lo = bits(io_instr, 19, 12) @[imme.scala 27:50]
    node uj_imm21_hi_lo = bits(io_instr, 20, 20) @[imme.scala 27:66]
    node uj_imm21_lo_hi = bits(io_instr, 30, 21) @[imme.scala 27:79]
    node uj_imm21_lo = cat(uj_imm21_lo_hi, UInt<1>("h0")) @[Cat.scala 30:58]
    node uj_imm21_hi_hi = cat(uj_imm21_hi_hi_hi, uj_imm21_hi_hi_lo) @[Cat.scala 30:58]
    node uj_imm21_hi = cat(uj_imm21_hi_hi, uj_imm21_hi_lo) @[Cat.scala 30:58]
    node uj_imm21 = cat(uj_imm21_hi, uj_imm21_lo) @[Cat.scala 30:58]
    node _io_uj_imm_T = bits(uj_imm21, 20, 20) @[imme.scala 28:44]
    node _io_uj_imm_T_1 = bits(_io_uj_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node io_uj_imm_hi = mux(_io_uj_imm_T_1, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 72:12]
    node _io_uj_imm_T_2 = cat(io_uj_imm_hi, uj_imm21) @[Cat.scala 30:58]
    node _io_uj_imm_T_3 = add(_io_uj_imm_T_2, io_pc_val) @[imme.scala 28:61]
    node _io_uj_imm_T_4 = tail(_io_uj_imm_T_3, 1) @[imme.scala 28:61]
    node _io_uj_imm_T_5 = asSInt(_io_uj_imm_T_4) @[imme.scala 28:74]
    node _io_u_imm_T = bits(io_instr, 31, 31) @[imme.scala 30:43]
    node _io_u_imm_T_1 = bits(_io_u_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node io_u_imm_hi = mux(_io_u_imm_T_1, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 72:12]
    node io_u_imm_lo = bits(io_instr, 31, 12) @[imme.scala 30:57]
    node _io_u_imm_T_2 = cat(io_u_imm_hi, io_u_imm_lo) @[Cat.scala 30:58]
    node _io_u_imm_T_3 = shl(_io_u_imm_T_2, 12) @[imme.scala 30:67]
    node _io_u_imm_T_4 = asSInt(_io_u_imm_T_3) @[imme.scala 30:74]
    node _io_i_imm_T = bits(io_instr, 31, 31) @[imme.scala 32:42]
    node _io_i_imm_T_1 = bits(_io_i_imm_T, 0, 0) @[Bitwise.scala 72:15]
    node io_i_imm_hi = mux(_io_i_imm_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 72:12]
    node io_i_imm_lo = bits(io_instr, 31, 20) @[imme.scala 32:56]
    node _io_i_imm_T_2 = cat(io_i_imm_hi, io_i_imm_lo) @[Cat.scala 30:58]
    node _io_i_imm_T_3 = asSInt(_io_i_imm_T_2) @[imme.scala 32:66]
    io_s_imm <= _io_s_imm_T_3 @[imme.scala 22:18]
    io_sb_imm <= _io_sb_imm_T_5 @[imme.scala 25:19]
    io_uj_imm <= asSInt(bits(_io_uj_imm_T_5, 31, 0)) @[imme.scala 28:19]
    io_u_imm <= asSInt(bits(_io_u_imm_T_4, 31, 0)) @[imme.scala 30:18]
    io_i_imm <= _io_i_imm_T_3 @[imme.scala 32:18]

  module jalr :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : SInt<32>
    input io_pc_addr : SInt<32>
    output io_out : SInt<32>

    node _io_out_T = add(io_addr, io_pc_addr) @[jalr.scala 11:22]
    node _io_out_T_1 = tail(_io_out_T, 1) @[jalr.scala 11:22]
    node _io_out_T_2 = asSInt(_io_out_T_1) @[jalr.scala 11:22]
    node _io_out_T_3 = and(_io_out_T_2, asSInt(UInt<33>("hfffffffe"))) @[jalr.scala 11:35]
    node _io_out_T_4 = asSInt(_io_out_T_3) @[jalr.scala 11:35]
    io_out <= asSInt(bits(_io_out_T_4, 31, 0)) @[jalr.scala 11:11]

  module alu_controler :
    input clock : Clock
    input reset : UInt<1>
    input io_alu_op : UInt<3>
    input io_func3 : UInt<3>
    input io_func7 : UInt<1>
    output io_x : UInt<5>

    node _T = eq(UInt<1>("h1"), io_alu_op) @[Conditional.scala 37:30]
    node _io_x_T = cat(UInt<1>("h0"), io_func3) @[Cat.scala 30:58]
    node _T_1 = eq(UInt<1>("h0"), io_alu_op) @[Conditional.scala 37:30]
    node io_x_hi = cat(UInt<1>("h0"), io_func7) @[Cat.scala 30:58]
    node _io_x_T_1 = cat(io_x_hi, io_func3) @[Cat.scala 30:58]
    node _T_2 = eq(UInt<2>("h2"), io_alu_op) @[Conditional.scala 37:30]
    node io_x_hi_1 = bits(io_alu_op, 1, 0) @[alu_controler.scala 22:32]
    node _io_x_T_2 = cat(io_x_hi_1, io_func3) @[Cat.scala 30:58]
    node _T_3 = eq(UInt<2>("h3"), io_alu_op) @[Conditional.scala 37:30]
    node _io_x_T_3 = mux(UInt<1>("h1"), UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 72:12]
    node _T_4 = eq(UInt<3>("h5"), io_alu_op) @[Conditional.scala 37:30]
    node _io_x_T_4 = mux(UInt<1>("h0"), UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 72:12]
    node _T_5 = eq(UInt<3>("h4"), io_alu_op) @[Conditional.scala 37:30]
    node _io_x_T_5 = mux(UInt<1>("h0"), UInt<5>("h1f"), UInt<5>("h0")) @[Bitwise.scala 72:12]
    node _GEN_0 = mux(_T_5, _io_x_T_5, UInt<1>("h0")) @[Conditional.scala 39:67 alu_controler.scala 31:17 alu_controler.scala 13:9]
    node _GEN_1 = mux(_T_4, _io_x_T_4, _GEN_0) @[Conditional.scala 39:67 alu_controler.scala 28:17]
    node _GEN_2 = mux(_T_3, _io_x_T_3, _GEN_1) @[Conditional.scala 39:67 alu_controler.scala 25:17]
    node _GEN_3 = mux(_T_2, _io_x_T_2, _GEN_2) @[Conditional.scala 39:67 alu_controler.scala 22:17]
    node _GEN_4 = mux(_T_1, _io_x_T_1, _GEN_3) @[Conditional.scala 39:67 alu_controler.scala 19:17]
    node _GEN_5 = mux(_T, _io_x_T, _GEN_4) @[Conditional.scala 40:58 alu_controler.scala 16:17]
    io_x <= _GEN_5

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
      reset => (UInt<1>("h0"), reg_pc) @[IF.scala 24:29]
    reg reg_pc4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_pc4) @[IF.scala 25:30]
    reg reg_ins : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_ins) @[IF.scala 26:30]
    io_pc_out <= reg_pc @[IF.scala 32:19]
    io_ins_out <= reg_ins @[IF.scala 34:20]
    io_pc4_out <= reg_pc4 @[IF.scala 33:20]
    reg_pc <= mux(reset, UInt<32>("h0"), io_pc_in) @[IF.scala 24:29 IF.scala 24:29 IF.scala 28:16]
    reg_pc4 <= mux(reset, UInt<32>("h0"), io_pc4_in) @[IF.scala 25:30 IF.scala 25:30 IF.scala 29:17]
    reg_ins <= mux(reset, UInt<32>("h0"), io_ins_in) @[IF.scala 26:30 IF.scala 26:30 IF.scala 30:17]

  module ID :
    input clock : Clock
    input reset : UInt<1>
    input io_memWrite_in : UInt<1>
    input io_memRead_in : UInt<1>
    input io_memToReg_in : UInt<1>
    input io_operandA_in : SInt<32>
    input io_operandB_in : SInt<32>
    input io_rd_in : UInt<5>
    input io_aluCtrl_in : UInt<5>
    input io_regWrite_in : UInt<1>
    input io_rs1Ins_in : UInt<5>
    input io_rs2Ins_in : UInt<5>
    input io_operandAsel_in : UInt<2>
    input io_operandBsel_in : UInt<1>
    input io_pc_in : UInt<32>
    input io_pc4_in : UInt<32>
    output io_memWrite_out : UInt<1>
    output io_memRead_out : UInt<1>
    output io_memToReg_out : UInt<1>
    output io_operandA_out : SInt<32>
    output io_operandB_out : SInt<32>
    output io_rd_out : UInt<5>
    output io_aluCtrl_out : UInt<5>
    output io_regWrite_out : UInt<1>
    output io_rs1Ins_out : UInt<5>
    output io_rs2Ins_out : UInt<5>
    output io_operandAsel_out : UInt<2>
    output io_operandBsel_out : UInt<1>
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
    io_aluCtrl_out <= reg_aluCtrl @[ID.scala 86:24]
    io_regWrite_out <= reg_regWrite @[ID.scala 87:25]
    io_rs1Ins_out <= reg_rs1Ins @[ID.scala 88:23]
    io_rs2Ins_out <= reg_rs2Ins @[ID.scala 89:23]
    io_operandAsel_out <= reg_operandAsel @[ID.scala 90:28]
    io_operandBsel_out <= reg_operandBsel @[ID.scala 91:28]
    io_pc_out <= reg_pc @[ID.scala 93:19]
    io_pc4_out <= reg_pc4 @[ID.scala 94:20]
    reg_memWrite <= mux(reset, UInt<1>("h0"), io_memWrite_in) @[ID.scala 43:35 ID.scala 43:35 ID.scala 61:22]
    reg_memRead <= mux(reset, UInt<1>("h0"), io_memRead_in) @[ID.scala 44:34 ID.scala 44:34 ID.scala 62:21]
    reg_memToReg <= mux(reset, UInt<1>("h0"), io_memToReg_in) @[ID.scala 45:35 ID.scala 45:35 ID.scala 63:22]
    reg_operandA <= mux(reset, asSInt(UInt<32>("h0")), io_operandA_in) @[ID.scala 46:35 ID.scala 46:35 ID.scala 64:22]
    reg_operandB <= mux(reset, asSInt(UInt<32>("h0")), io_operandB_in) @[ID.scala 47:35 ID.scala 47:35 ID.scala 65:22]
    reg_rd <= mux(reset, UInt<5>("h0"), io_rd_in) @[ID.scala 48:29 ID.scala 48:29 ID.scala 66:16]
    reg_aluCtrl <= mux(reset, UInt<5>("h0"), io_aluCtrl_in) @[ID.scala 50:34 ID.scala 50:34 ID.scala 68:21]
    reg_regWrite <= mux(reset, UInt<1>("h0"), io_regWrite_in) @[ID.scala 51:35 ID.scala 51:35 ID.scala 69:22]
    reg_rs1Ins <= mux(reset, UInt<5>("h0"), io_rs1Ins_in) @[ID.scala 52:33 ID.scala 52:33 ID.scala 70:20]
    reg_rs2Ins <= mux(reset, UInt<5>("h0"), io_rs2Ins_in) @[ID.scala 53:33 ID.scala 53:33 ID.scala 71:20]
    reg_operandAsel <= mux(reset, UInt<2>("h0"), io_operandAsel_in) @[ID.scala 54:38 ID.scala 54:38 ID.scala 72:25]
    reg_operandBsel <= mux(reset, UInt<1>("h0"), io_operandBsel_in) @[ID.scala 55:38 ID.scala 55:38 ID.scala 73:25]
    reg_pc <= mux(reset, UInt<32>("h0"), io_pc_in) @[ID.scala 57:29 ID.scala 57:29 ID.scala 75:16]
    reg_pc4 <= mux(reset, UInt<32>("h0"), io_pc4_in) @[ID.scala 58:30 ID.scala 58:30 ID.scala 76:17]

  module EX :
    input clock : Clock
    input reset : UInt<1>
    input io_memWrite_in : UInt<1>
    input io_memRead_in : UInt<1>
    input io_memToReg_in : UInt<1>
    input io_rd_in : UInt<5>
    input io_aluOutput_in : SInt<32>
    input io_regWrite_in : UInt<1>
    input io_rs2Sel_in : UInt<5>
    input io_baseReg_in : SInt<32>
    input io_offSet_in : SInt<32>
    output io_memWrite_out : UInt<1>
    output io_memRead_out : UInt<1>
    output io_memToReg_out : UInt<1>
    output io_rd_out : UInt<5>
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
    io_aluOutput_out <= reg_aluOutput @[EX.scala 56:26]
    io_regWrite_out <= reg_regWrite @[EX.scala 57:25]
    io_rs2Sel_out <= reg_rs2Sel @[EX.scala 58:23]
    io_baseReg_out <= reg_baseReg @[EX.scala 59:24]
    io_offSet_out <= reg_offSet @[EX.scala 60:23]
    reg_memWrite <= mux(reset, UInt<1>("h0"), io_memWrite_in) @[EX.scala 29:31 EX.scala 29:31 EX.scala 40:22]
    reg_memRead <= mux(reset, UInt<1>("h0"), io_memRead_in) @[EX.scala 30:34 EX.scala 30:34 EX.scala 41:21]
    reg_memToReg <= mux(reset, UInt<1>("h0"), io_memToReg_in) @[EX.scala 31:35 EX.scala 31:35 EX.scala 42:22]
    reg_rd <= mux(reset, UInt<5>("h0"), io_rd_in) @[EX.scala 32:29 EX.scala 32:29 EX.scala 43:16]
    reg_strData <= mux(reset, asSInt(UInt<32>("h0")), reg_strData) @[EX.scala 33:34 EX.scala 33:34 EX.scala 33:34]
    reg_aluOutput <= mux(reset, asSInt(UInt<32>("h0")), io_aluOutput_in) @[EX.scala 34:36 EX.scala 34:36 EX.scala 45:23]
    reg_regWrite <= mux(reset, UInt<1>("h0"), io_regWrite_in) @[EX.scala 35:35 EX.scala 35:35 EX.scala 46:22]
    reg_rs2Sel <= mux(reset, UInt<5>("h0"), io_rs2Sel_in) @[EX.scala 36:33 EX.scala 36:33 EX.scala 47:20]
    reg_baseReg <= mux(reset, asSInt(UInt<32>("h0")), io_baseReg_in) @[EX.scala 37:34 EX.scala 37:34 EX.scala 48:21]
    reg_offSet <= mux(reset, asSInt(UInt<32>("h0")), io_offSet_in) @[EX.scala 38:33 EX.scala 38:33 EX.scala 49:20]

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

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_out : UInt<32>
    output io_addr : UInt<10>

    inst pc of pccounter @[top.scala 16:18]
    inst data_mem of datamem @[top.scala 17:24]
    inst inst_mem of InstMem @[top.scala 18:25]
    inst reg_file of reg @[top.scala 19:24]
    inst controler of controler @[top.scala 20:27]
    inst alu of ALU4 @[top.scala 21:20]
    inst branch of BranchControl @[top.scala 22:24]
    inst imm of ImmdValGen1 @[top.scala 23:20]
    inst Jalr of jalr @[top.scala 24:22]
    inst alu_cnt of alu_controler @[top.scala 25:24]
    inst IF of Inst_fetch @[top.scala 28:18]
    inst ID of ID @[top.scala 29:19]
    inst EX of EX @[top.scala 30:19]
    inst Mem_wb of MEM_WB @[top.scala 31:22]
    node _inst_mem_io_addr_T = bits(pc.io_pc_out, 11, 2) @[top.scala 34:35]
    node _reg_file_io_rs1_T = bits(IF.io_ins_out, 19, 15) @[top.scala 41:35]
    node _reg_file_io_rs2_T = bits(IF.io_ins_out, 24, 20) @[top.scala 42:35]
    node _controler_io_opcod_T = bits(IF.io_ins_out, 6, 0) @[top.scala 45:38]
    node _ID_io_rd_in_T = bits(IF.io_ins_out, 11, 7) @[top.scala 48:31]
    node _ID_io_rs1Ins_in_T = bits(IF.io_ins_out, 19, 15) @[top.scala 49:35]
    node _ID_io_rs2Ins_in_T = bits(IF.io_ins_out, 24, 20) @[top.scala 50:35]
    reg func3 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), func3) @[top.scala 54:22]
    node _func3_T = bits(IF.io_ins_out, 14, 12) @[top.scala 55:25]
    reg func7 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), func7) @[top.scala 56:23]
    node _func7_T = bits(IF.io_ins_out, 30, 30) @[top.scala 57:25]
    node _ID_io_operandA_in_T = asSInt(controler.io_op_a) @[top.scala 72:42]
    node _ID_io_operandB_in_T = asSInt(controler.io_op_b) @[top.scala 73:42]
    node _ID_io_operandAsel_in_T = asUInt(reg_file.io_rd1) @[top.scala 77:43]
    node _ID_io_operandBsel_in_T = asUInt(reg_file.io_rd2) @[top.scala 78:43]
    node _alu_io_in1_T = asUInt(ID.io_operandA_out) @[top.scala 94:37]
    node _alu_io_in1_T_1 = eq(_alu_io_in1_T, UInt<1>("h0")) @[top.scala 94:43]
    node _alu_io_in1_T_2 = asUInt(ID.io_operandA_out) @[top.scala 94:77]
    node _alu_io_in1_T_3 = eq(_alu_io_in1_T_2, UInt<2>("h3")) @[top.scala 94:83]
    node _alu_io_in1_T_4 = or(_alu_io_in1_T_1, _alu_io_in1_T_3) @[top.scala 94:56]
    node _alu_io_in1_T_5 = asUInt(ID.io_operandA_out) @[top.scala 95:37]
    node _alu_io_in1_T_6 = eq(_alu_io_in1_T_5, UInt<1>("h1")) @[top.scala 95:43]
    node _alu_io_in1_T_7 = asSInt(ID.io_pc4_out) @[top.scala 95:74]
    node _alu_io_in1_T_8 = asUInt(ID.io_operandA_out) @[top.scala 96:37]
    node _alu_io_in1_T_9 = eq(_alu_io_in1_T_8, UInt<2>("h2")) @[top.scala 96:43]
    node _alu_io_in1_T_10 = asSInt(ID.io_pc_out) @[top.scala 96:73]
    node _alu_io_in1_T_11 = mux(_alu_io_in1_T_9, _alu_io_in1_T_10, asSInt(UInt<1>("h0"))) @[Mux.scala 98:16]
    node _alu_io_in1_T_12 = mux(_alu_io_in1_T_6, _alu_io_in1_T_7, _alu_io_in1_T_11) @[Mux.scala 98:16]
    node _alu_io_in1_T_13 = mux(_alu_io_in1_T_4, reg_file.io_rd1, _alu_io_in1_T_12) @[Mux.scala 98:16]
    node _mux_imm_T = eq(UInt<1>("h1"), controler.io_extend_sel) @[Mux.scala 80:60]
    node _mux_imm_T_1 = mux(_mux_imm_T, imm.io_s_imm, imm.io_i_imm) @[Mux.scala 80:57]
    node _mux_imm_T_2 = eq(UInt<2>("h2"), controler.io_extend_sel) @[Mux.scala 80:60]
    node _mux_imm_T_3 = mux(_mux_imm_T_2, imm.io_u_imm, _mux_imm_T_1) @[Mux.scala 80:57]
    node _mux_imm_T_4 = eq(UInt<2>("h3"), controler.io_extend_sel) @[Mux.scala 80:60]
    node mux_imm = mux(_mux_imm_T_4, reg_file.io_rd2, _mux_imm_T_3) @[Mux.scala 80:57]
    node mux2_alu = mux(controler.io_op_b, mux_imm, reg_file.io_rd2) @[top.scala 107:23]
    reg immreg : SInt<32>, clock with :
      reset => (UInt<1>("h0"), immreg) @[top.scala 108:23]
    node _alu_io_in1_T_14 = asSInt(ID.io_rs1Ins_out) @[top.scala 111:34]
    node _T = eq(ID.io_operandBsel_out, UInt<1>("h1")) @[top.scala 112:32]
    node _alu_io_in2_T = asSInt(ID.io_rs2Ins_out) @[top.scala 115:36]
    node _GEN_0 = mux(_T, immreg, _alu_io_in2_T) @[top.scala 112:44 top.scala 113:16 top.scala 115:16]
    node _T_1 = eq(controler.io_next_pc, UInt<2>("h3")) @[top.scala 144:31]
    node _pc_io_addr_T = asUInt(Jalr.io_out) @[top.scala 145:43]
    node _T_2 = eq(controler.io_next_pc, UInt<2>("h2")) @[top.scala 149:41]
    node _pc_io_addr_T_1 = asUInt(imm.io_uj_imm) @[top.scala 150:45]
    node _GEN_1 = mux(_T_2, _pc_io_addr_T_1, pc.io_pc_4) @[top.scala 149:53 top.scala 150:28 top.scala 40:15]
    node _GEN_2 = mux(_T_2, UInt<1>("h0"), inst_mem.io_inst) @[top.scala 149:53 top.scala 151:30 top.scala 39:17]
    node _GEN_3 = mux(_T_2, UInt<1>("h0"), pc.io_pc_out) @[top.scala 149:53 top.scala 152:29 top.scala 37:16]
    node _GEN_4 = mux(_T_2, UInt<1>("h0"), pc.io_pc_4) @[top.scala 149:53 top.scala 153:30 top.scala 38:17]
    node _GEN_5 = mux(_T_1, _pc_io_addr_T, _GEN_1) @[top.scala 144:43 top.scala 145:28]
    node _GEN_6 = mux(_T_1, UInt<1>("h0"), _GEN_2) @[top.scala 144:43 top.scala 146:30]
    node _GEN_7 = mux(_T_1, UInt<1>("h0"), _GEN_3) @[top.scala 144:43 top.scala 147:29]
    node _GEN_8 = mux(_T_1, UInt<1>("h0"), _GEN_4) @[top.scala 144:43 top.scala 148:30]
    node _T_3 = eq(controler.io_op_a, UInt<1>("h1")) @[top.scala 162:32]
    node _ID_io_operandA_in_T_1 = asSInt(IF.io_pc_out) @[top.scala 163:53]
    node _T_4 = eq(controler.io_op_a, UInt<2>("h2")) @[top.scala 164:38]
    node _ID_io_operandA_in_T_2 = asSInt(IF.io_pc4_out) @[top.scala 165:54]
    node _GEN_9 = mux(_T_4, _ID_io_operandA_in_T_2, reg_file.io_rd1) @[top.scala 164:50 top.scala 165:35 top.scala 167:35]
    node _GEN_10 = mux(_T_3, _ID_io_operandA_in_T_1, _GEN_9) @[top.scala 162:44 top.scala 163:35]
    node _T_5 = eq(controler.io_extend_sel, UInt<1>("h0")) @[top.scala 171:38]
    node _T_6 = eq(controler.io_op_b, UInt<1>("h1")) @[top.scala 171:70]
    node _T_7 = and(_T_5, _T_6) @[top.scala 171:50]
    node _T_8 = eq(controler.io_extend_sel, UInt<1>("h1")) @[top.scala 173:44]
    node _T_9 = eq(controler.io_op_b, UInt<1>("h1")) @[top.scala 173:76]
    node _T_10 = and(_T_8, _T_9) @[top.scala 173:56]
    node _T_11 = eq(controler.io_extend_sel, UInt<2>("h2")) @[top.scala 175:44]
    node _T_12 = eq(controler.io_op_b, UInt<1>("h1")) @[top.scala 175:76]
    node _T_13 = and(_T_11, _T_12) @[top.scala 175:56]
    node _GEN_11 = mux(_T_13, imm.io_s_imm, reg_file.io_rd2) @[top.scala 175:84 top.scala 176:35 top.scala 178:35]
    node _GEN_12 = mux(_T_10, imm.io_u_imm, _GEN_11) @[top.scala 173:84 top.scala 174:35]
    node _GEN_13 = mux(_T_7, imm.io_i_imm, _GEN_12) @[top.scala 171:78 top.scala 172:35]
    node _mux_b_T = asUInt(imm.io_sb_imm) @[top.scala 187:63]
    node mux_b = mux(branch.io_br_taken, pc.io_pc_4, _mux_b_T) @[top.scala 187:18]
    node _mux_d_T = asUInt(imm.io_uj_imm) @[top.scala 193:44]
    node _mux_d_T_1 = asUInt(Jalr.io_out) @[top.scala 194:42]
    node _mux_d_T_2 = eq(UInt<1>("h1"), controler.io_next_pc) @[Mux.scala 80:60]
    node _mux_d_T_3 = mux(_mux_d_T_2, mux_b, pc.io_pc_4) @[Mux.scala 80:57]
    node _mux_d_T_4 = eq(UInt<2>("h2"), controler.io_next_pc) @[Mux.scala 80:60]
    node _mux_d_T_5 = mux(_mux_d_T_4, _mux_d_T, _mux_d_T_3) @[Mux.scala 80:57]
    node _mux_d_T_6 = eq(UInt<2>("h3"), controler.io_next_pc) @[Mux.scala 80:60]
    node mux_d = mux(_mux_d_T_6, _mux_d_T_1, _mux_d_T_5) @[Mux.scala 80:57]
    node _data_mem_io_Addr_T = bits(EX.io_aluOutput_out, 11, 2) @[top.scala 199:42]
    node _data_mem_io_Data_T = asSInt(EX.io_rs2Sel_out) @[top.scala 202:40]
    node _reg_file_io_WriteData_T = asSInt(Mem_wb.io_rs2Sel_out) @[top.scala 204:49]
    io_out <= UInt<1>("h0") @[top.scala 14:11]
    io_addr <= inst_mem.io_addr @[top.scala 35:12]
    pc.clock <= clock
    pc.reset <= reset
    pc.io_addr <= mux_d @[top.scala 196:15]
    data_mem.clock <= clock
    data_mem.reset <= reset
    data_mem.io_Addr <= bits(_data_mem_io_Addr_T, 7, 0) @[top.scala 199:21]
    data_mem.io_Data <= _data_mem_io_Data_T @[top.scala 202:21]
    data_mem.io_MemWrite <= EX.io_memWrite_out @[top.scala 200:25]
    data_mem.io_MemRead <= EX.io_memRead_out @[top.scala 201:24]
    inst_mem.clock <= clock
    inst_mem.reset <= reset
    inst_mem.io_addr <= _inst_mem_io_addr_T @[top.scala 34:21]
    reg_file.clock <= clock
    reg_file.reset <= reset
    reg_file.io_write <= Mem_wb.io_regWrite_out @[top.scala 82:22]
    reg_file.io_rs1 <= ID.io_rs1Ins_out @[top.scala 84:20]
    reg_file.io_rs2 <= ID.io_rs2Ins_out @[top.scala 85:20]
    reg_file.io_rd <= Mem_wb.io_rd_out @[top.scala 83:19]
    reg_file.io_WriteData <= _reg_file_io_WriteData_T @[top.scala 204:26]
    controler.clock <= clock
    controler.reset <= reset
    controler.io_opcod <= _controler_io_opcod_T @[top.scala 45:23]
    alu.clock <= clock
    alu.reset <= reset
    alu.io_alu_Op <= ID.io_aluCtrl_out @[top.scala 118:18]
    alu.io_in1 <= _alu_io_in1_T_14 @[top.scala 111:15]
    alu.io_in2 <= _GEN_0
    branch.clock <= clock
    branch.reset <= reset
    branch.io_alu_opp <= controler.io_aluop @[top.scala 181:22]
    branch.io_branch <= controler.io_branch @[top.scala 159:22]
    branch.io_arg_x <= ID.io_operandA_out @[top.scala 169:20]
    branch.io_arg_y <= ID.io_operandB_out @[top.scala 180:20]
    imm.clock <= clock
    imm.reset <= reset
    imm.io_instr <= IF.io_ins_out @[top.scala 90:17]
    imm.io_pc_val <= IF.io_pc_out @[top.scala 91:18]
    Jalr.clock <= clock
    Jalr.reset <= reset
    Jalr.io_addr <= reg_file.io_rd1 @[top.scala 184:17]
    Jalr.io_pc_addr <= imm.io_i_imm @[top.scala 183:20]
    alu_cnt.clock <= clock
    alu_cnt.reset <= reset
    alu_cnt.io_alu_op <= controler.io_aluop @[top.scala 53:22]
    alu_cnt.io_func3 <= func3 @[top.scala 119:21]
    alu_cnt.io_func7 <= func7 @[top.scala 120:21]
    IF.clock <= clock
    IF.reset <= reset
    IF.io_pc_in <= _GEN_7
    IF.io_pc4_in <= _GEN_8
    IF.io_ins_in <= _GEN_6
    ID.clock <= clock
    ID.reset <= reset
    ID.io_memWrite_in <= controler.io_memwrite @[top.scala 67:22]
    ID.io_memRead_in <= controler.io_memread @[top.scala 68:21]
    ID.io_memToReg_in <= controler.io_memtoreg @[top.scala 69:22]
    ID.io_operandA_in <= _GEN_10
    ID.io_operandB_in <= _GEN_13
    ID.io_rd_in <= _ID_io_rd_in_T @[top.scala 48:16]
    ID.io_aluCtrl_in <= alu_cnt.io_x @[top.scala 76:21]
    ID.io_regWrite_in <= controler.io_regwrite @[top.scala 71:22]
    ID.io_rs1Ins_in <= _ID_io_rs1Ins_in_T @[top.scala 49:20]
    ID.io_rs2Ins_in <= _ID_io_rs2Ins_in_T @[top.scala 50:20]
    ID.io_operandAsel_in <= bits(_ID_io_operandAsel_in_T, 1, 0) @[top.scala 77:25]
    ID.io_operandBsel_in <= bits(_ID_io_operandBsel_in_T, 0, 0) @[top.scala 78:25]
    ID.io_pc_in <= IF.io_pc_out @[top.scala 46:16]
    ID.io_pc4_in <= IF.io_pc4_out @[top.scala 47:17]
    EX.clock <= clock
    EX.reset <= reset
    EX.io_memWrite_in <= ID.io_memWrite_out @[top.scala 125:22]
    EX.io_memRead_in <= ID.io_memRead_out @[top.scala 126:21]
    EX.io_memToReg_in <= ID.io_memToReg_out @[top.scala 127:22]
    EX.io_rd_in <= ID.io_rd_out @[top.scala 123:16]
    EX.io_aluOutput_in <= alu.io_out @[top.scala 122:23]
    EX.io_regWrite_in <= ID.io_regWrite_out @[top.scala 128:27]
    EX.io_rs2Sel_in <= ID.io_rs2Ins_out @[top.scala 124:20]
    EX.io_baseReg_in <= ID.io_operandA_out @[top.scala 129:26]
    EX.io_offSet_in <= ID.io_operandB_out @[top.scala 130:25]
    Mem_wb.clock <= clock
    Mem_wb.reset <= reset
    Mem_wb.io_memToReg_in <= EX.io_memToReg_out @[top.scala 138:26]
    Mem_wb.io_rd_in <= EX.io_rd_out @[top.scala 135:20]
    Mem_wb.io_dataOut_in <= data_mem.io_out @[top.scala 134:25]
    Mem_wb.io_aluOutput_in <= EX.io_aluOutput_out @[top.scala 133:27]
    Mem_wb.io_regWrite_in <= EX.io_regWrite_out @[top.scala 136:26]
    Mem_wb.io_rs2Sel_in <= EX.io_rs2Sel_out @[top.scala 142:24]
    Mem_wb.io_baseReg_in <= EX.io_baseReg_out @[top.scala 140:25]
    Mem_wb.io_offSet_in <= EX.io_offSet_out @[top.scala 141:24]
    Mem_wb.io_MemRead_in <= EX.io_memRead_out @[top.scala 137:25]
    Mem_wb.io_memWrite_in <= EX.io_memWrite_out @[top.scala 139:26]
    func3 <= mux(reset, UInt<3>("h0"), _func3_T) @[top.scala 54:22 top.scala 54:22 top.scala 55:10]
    func7 <= mux(reset, UInt<1>("h0"), _func7_T) @[top.scala 56:23 top.scala 56:23 top.scala 57:10]
    immreg <= mux(reset, asSInt(UInt<32>("h0")), immreg) @[top.scala 108:23 top.scala 108:23 top.scala 108:23]
