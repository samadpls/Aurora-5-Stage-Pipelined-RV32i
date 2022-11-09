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
    node _T = eq(io_MemWrite, UInt<1>("h1")) @[datamem.scala 15:27]
    node _GEN_0 = validif(_T, io_Addr) @[datamem.scala 15:35]
    node _GEN_1 = validif(_T, clock) @[datamem.scala 15:35]
    node _GEN_2 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[datamem.scala 15:35 datamem.scala 13:22]
    node _GEN_3 = validif(_T, UInt<1>("h1")) @[datamem.scala 15:35]
    node _GEN_4 = validif(_T, io_Data) @[datamem.scala 15:35]
    node _T_1 = eq(io_MemRead, UInt<1>("h1")) @[datamem.scala 18:25]
    node _GEN_5 = validif(_T_1, io_Addr) @[datamem.scala 18:33 datamem.scala 19:35]
    node _GEN_6 = validif(_T_1, clock) @[datamem.scala 18:33 datamem.scala 19:35]
    node _GEN_7 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[datamem.scala 18:33 datamem.scala 19:35 datamem.scala 13:22]
    node _GEN_8 = mux(_T_1, mem.io_out_MPORT.data, asSInt(UInt<1>("h0"))) @[datamem.scala 18:33 datamem.scala 19:24 datamem.scala 21:28]
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
    node _GEN_9 = mux(_T_5, UInt<1>("h1"), _GEN_6) @[Conditional.scala 39:67 controler.scala 96:24]
    node _GEN_10 = mux(_T_5, UInt<1>("h0"), _GEN_7) @[Conditional.scala 39:67 controler.scala 97:24]
    node _GEN_11 = mux(_T_5, UInt<3>("h5"), _GEN_5) @[Conditional.scala 39:67 controler.scala 98:21]
    node _GEN_12 = mux(_T_5, UInt<1>("h1"), _GEN_7) @[Conditional.scala 39:67 controler.scala 99:20]
    node _GEN_13 = mux(_T_5, UInt<1>("h1"), _GEN_8) @[Conditional.scala 39:67 controler.scala 100:26]
    node _GEN_14 = mux(_T_5, UInt<1>("h0"), _GEN_4) @[Conditional.scala 39:67 controler.scala 102:22]
    node _GEN_15 = mux(_T_5, UInt<1>("h0"), _GEN_6) @[Conditional.scala 39:67 controler.scala 103:24]
    node _GEN_16 = mux(_T_5, UInt<1>("h0"), _GEN_8) @[Conditional.scala 39:67 controler.scala 105:20]
    node _GEN_17 = mux(_T_4, UInt<1>("h1"), _GEN_10) @[Conditional.scala 39:67 controler.scala 84:24]
    node _GEN_18 = mux(_T_4, UInt<1>("h0"), _GEN_9) @[Conditional.scala 39:67 controler.scala 85:24]
    node _GEN_19 = mux(_T_4, UInt<1>("h0"), _GEN_14) @[Conditional.scala 39:67 controler.scala 86:22]
    node _GEN_20 = mux(_T_4, UInt<1>("h0"), _GEN_15) @[Conditional.scala 39:67 controler.scala 87:24]
    node _GEN_21 = mux(_T_4, UInt<1>("h0"), _GEN_11) @[Conditional.scala 39:67 controler.scala 89:21]
    node _GEN_22 = mux(_T_4, UInt<1>("h0"), _GEN_16) @[Conditional.scala 39:67 controler.scala 90:20]
    node _GEN_23 = mux(_T_4, UInt<1>("h0"), _GEN_12) @[Conditional.scala 39:67 controler.scala 91:20]
    node _GEN_24 = mux(_T_4, UInt<1>("h0"), _GEN_13) @[Conditional.scala 39:67 controler.scala 92:26]
    node _GEN_25 = mux(_T_3, UInt<1>("h1"), _GEN_17) @[Conditional.scala 39:67 controler.scala 71:24]
    node _GEN_26 = mux(_T_3, UInt<2>("h3"), _GEN_21) @[Conditional.scala 39:67 controler.scala 72:21]
    node _GEN_27 = mux(_T_3, UInt<1>("h1"), _GEN_22) @[Conditional.scala 39:67 controler.scala 73:20]
    node _GEN_28 = mux(_T_3, UInt<1>("h1"), _GEN_23) @[Conditional.scala 39:67 controler.scala 74:20]
    node _GEN_29 = mux(_T_3, UInt<2>("h3"), _GEN_19) @[Conditional.scala 39:67 controler.scala 75:23]
    node _GEN_30 = mux(_T_3, UInt<1>("h0"), _GEN_18) @[Conditional.scala 39:67 controler.scala 76:24]
    node _GEN_31 = mux(_T_3, UInt<1>("h0"), _GEN_19) @[Conditional.scala 39:67 controler.scala 77:22]
    node _GEN_32 = mux(_T_3, UInt<1>("h0"), _GEN_20) @[Conditional.scala 39:67 controler.scala 78:24]
    node _GEN_33 = mux(_T_3, UInt<1>("h0"), _GEN_24) @[Conditional.scala 39:67 controler.scala 80:26]
    node _GEN_34 = mux(_T_2, UInt<1>("h1"), _GEN_25) @[Conditional.scala 39:67 controler.scala 58:24]
    node _GEN_35 = mux(_T_2, UInt<2>("h3"), _GEN_26) @[Conditional.scala 39:67 controler.scala 59:21]
    node _GEN_36 = mux(_T_2, UInt<1>("h1"), _GEN_27) @[Conditional.scala 39:67 controler.scala 60:20]
    node _GEN_37 = mux(_T_2, UInt<2>("h2"), _GEN_29) @[Conditional.scala 39:67 controler.scala 61:23]
    node _GEN_38 = mux(_T_2, UInt<1>("h0"), _GEN_30) @[Conditional.scala 39:67 controler.scala 62:24]
    node _GEN_39 = mux(_T_2, UInt<1>("h0"), _GEN_31) @[Conditional.scala 39:67 controler.scala 63:22]
    node _GEN_40 = mux(_T_2, UInt<1>("h0"), _GEN_32) @[Conditional.scala 39:67 controler.scala 64:24]
    node _GEN_41 = mux(_T_2, UInt<1>("h0"), _GEN_28) @[Conditional.scala 39:67 controler.scala 66:20]
    node _GEN_42 = mux(_T_2, UInt<1>("h0"), _GEN_33) @[Conditional.scala 39:67 controler.scala 67:26]
    node _GEN_43 = mux(_T_1, UInt<1>("h1"), _GEN_34) @[Conditional.scala 39:67 controler.scala 46:24]
    node _GEN_44 = mux(_T_1, UInt<1>("h1"), _GEN_40) @[Conditional.scala 39:67 controler.scala 47:23]
    node _GEN_45 = mux(_T_1, UInt<3>("h4"), _GEN_35) @[Conditional.scala 39:67 controler.scala 49:21]
    node _GEN_46 = mux(_T_1, UInt<1>("h1"), _GEN_41) @[Conditional.scala 39:67 controler.scala 50:20]
    node _GEN_47 = mux(_T_1, UInt<1>("h0"), _GEN_38) @[Conditional.scala 39:67 controler.scala 51:24]
    node _GEN_48 = mux(_T_1, UInt<1>("h0"), _GEN_39) @[Conditional.scala 39:67 controler.scala 52:22]
    node _GEN_49 = mux(_T_1, UInt<1>("h0"), _GEN_36) @[Conditional.scala 39:67 controler.scala 53:20]
    node _GEN_50 = mux(_T_1, UInt<1>("h0"), _GEN_42) @[Conditional.scala 39:67 controler.scala 54:26]
    node _GEN_51 = mux(_T_1, UInt<1>("h0"), _GEN_37) @[Conditional.scala 39:67 controler.scala 55:23]
    node _GEN_52 = mux(_T, UInt<1>("h1"), _GEN_43) @[Conditional.scala 40:58 controler.scala 34:20]
    node _GEN_53 = mux(_T, UInt<1>("h1"), _GEN_45) @[Conditional.scala 40:58 controler.scala 35:17]
    node _GEN_54 = mux(_T, UInt<1>("h1"), _GEN_46) @[Conditional.scala 40:58 controler.scala 36:16]
    node _GEN_55 = mux(_T, UInt<1>("h0"), _GEN_47) @[Conditional.scala 40:58 controler.scala 37:20]
    node _GEN_56 = mux(_T, UInt<1>("h0"), _GEN_48) @[Conditional.scala 40:58 controler.scala 38:18]
    node _GEN_57 = mux(_T, UInt<1>("h0"), _GEN_44) @[Conditional.scala 40:58 controler.scala 39:20]
    node _GEN_58 = mux(_T, UInt<1>("h0"), _GEN_49) @[Conditional.scala 40:58 controler.scala 41:16]
    node _GEN_59 = mux(_T, UInt<1>("h0"), _GEN_50) @[Conditional.scala 40:58 controler.scala 42:22]
    node _GEN_60 = mux(_T, UInt<1>("h0"), _GEN_51) @[Conditional.scala 40:58 controler.scala 43:19]
    io_memwrite <= _GEN_55
    io_branch <= _GEN_56
    io_memread <= _GEN_57
    io_regwrite <= _GEN_52
    io_memtoreg <= _GEN_57
    io_aluop <= _GEN_53
    io_op_a <= _GEN_58
    io_op_b <= _GEN_54
    io_extend_sel <= _GEN_59
    io_next_pc <= _GEN_60

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
    input io_operandAsel_in : UInt<2>
    input io_operandBsel_in : UInt<1>
    input io_br_en_in : UInt<1>
    input io_aluOp_in : UInt<3>
    input io_regWrite_in : UInt<1>
    input io_operandA_in : SInt<32>
    input io_operandB_in : SInt<32>
    input io_rd_in : UInt<5>
    input io_func3 : UInt<3>
    input io_func7 : UInt<7>
    input io_rs1Ins_in : UInt<5>
    input io_rs2Ins_in : UInt<5>
    input io_pc_in : UInt<32>
    input io_pc4_in : UInt<32>
    input io_NextPc : UInt<2>
    input io_imm : SInt<32>
    output io_memWrite_out : UInt<1>
    output io_memRead_out : UInt<1>
    output io_memToReg_out : UInt<1>
    output io_operandAsel_out : UInt<2>
    output io_operandBsel_out : UInt<1>
    output io_br_en_out : UInt<1>
    output io_aluOp_out : UInt<3>
    output io_regWrite_out : UInt<1>
    output io_operandA_out : SInt<32>
    output io_operandB_out : SInt<32>
    output io_rd_out : UInt<5>
    output io_func3_o : UInt<3>
    output io_func7_o : UInt<7>
    output io_rs1Ins_out : UInt<5>
    output io_rs2Ins_out : UInt<5>
    output io_pc_out : UInt<32>
    output io_pc4_out : UInt<32>
    output io_NextPc_out : UInt<2>
    output io_imm_out : SInt<32>

    reg reg_memWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memWrite) @[ID.scala 57:35]
    reg reg_memRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memRead) @[ID.scala 58:34]
    reg reg_fun3 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), reg_fun3) @[ID.scala 59:29]
    reg reg_fun7 : UInt<7>, clock with :
      reset => (UInt<1>("h0"), reg_fun7) @[ID.scala 60:29]
    reg reg_memToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_memToReg) @[ID.scala 61:35]
    reg reg_operandAsel : UInt<2>, clock with :
      reset => (UInt<1>("h0"), reg_operandAsel) @[ID.scala 62:38]
    reg reg_operandBsel : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_operandBsel) @[ID.scala 63:38]
    reg reg_br_en : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_br_en) @[ID.scala 64:28]
    reg reg_aluOp : UInt<3>, clock with :
      reset => (UInt<1>("h0"), reg_aluOp) @[ID.scala 65:32]
    reg reg_regWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_regWrite) @[ID.scala 66:35]
    reg reg_operandA : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_operandA) @[ID.scala 67:35]
    reg reg_operandB : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_operandB) @[ID.scala 68:35]
    reg reg_rd : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rd) @[ID.scala 69:29]
    reg reg_rs1Ins : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rs1Ins) @[ID.scala 71:33]
    reg reg_rs2Ins : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_rs2Ins) @[ID.scala 72:33]
    reg reg_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_pc) @[ID.scala 73:29]
    reg reg_pc4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_pc4) @[ID.scala 74:30]
    reg reg_NextPc : UInt<2>, clock with :
      reset => (UInt<1>("h0"), reg_NextPc) @[ID.scala 76:33]
    reg reg_imm : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_imm) @[ID.scala 77:29]
    io_memWrite_out <= reg_memWrite @[ID.scala 103:25]
    io_memRead_out <= reg_memRead @[ID.scala 104:24]
    io_memToReg_out <= reg_memToReg @[ID.scala 105:25]
    io_operandAsel_out <= reg_operandAsel @[ID.scala 116:28]
    io_operandBsel_out <= reg_operandBsel @[ID.scala 117:28]
    io_br_en_out <= reg_br_en @[ID.scala 118:18]
    io_aluOp_out <= reg_aluOp @[ID.scala 112:22]
    io_regWrite_out <= reg_regWrite @[ID.scala 113:25]
    io_operandA_out <= reg_operandA @[ID.scala 108:25]
    io_operandB_out <= reg_operandB @[ID.scala 109:25]
    io_rd_out <= reg_rd @[ID.scala 110:19]
    io_func3_o <= reg_fun3 @[ID.scala 106:19]
    io_func7_o <= reg_fun7 @[ID.scala 107:19]
    io_rs1Ins_out <= reg_rs1Ins @[ID.scala 114:23]
    io_rs2Ins_out <= reg_rs2Ins @[ID.scala 115:23]
    io_pc_out <= reg_pc @[ID.scala 119:19]
    io_pc4_out <= reg_pc4 @[ID.scala 120:20]
    io_NextPc_out <= reg_NextPc @[ID.scala 122:23]
    io_imm_out <= reg_imm @[ID.scala 123:19]
    reg_memWrite <= mux(reset, UInt<1>("h0"), io_memWrite_in) @[ID.scala 57:35 ID.scala 57:35 ID.scala 80:22]
    reg_memRead <= mux(reset, UInt<1>("h0"), io_memRead_in) @[ID.scala 58:34 ID.scala 58:34 ID.scala 83:21]
    reg_fun3 <= mux(reset, UInt<3>("h0"), io_func3) @[ID.scala 59:29 ID.scala 59:29 ID.scala 81:17]
    reg_fun7 <= mux(reset, UInt<7>("h0"), io_func7) @[ID.scala 60:29 ID.scala 60:29 ID.scala 82:17]
    reg_memToReg <= mux(reset, UInt<1>("h0"), io_memToReg_in) @[ID.scala 61:35 ID.scala 61:35 ID.scala 84:22]
    reg_operandAsel <= mux(reset, UInt<2>("h0"), io_operandAsel_in) @[ID.scala 62:38 ID.scala 62:38 ID.scala 93:25]
    reg_operandBsel <= mux(reset, UInt<1>("h0"), io_operandBsel_in) @[ID.scala 63:38 ID.scala 63:38 ID.scala 94:25]
    reg_br_en <= mux(reset, UInt<1>("h0"), io_br_en_in) @[ID.scala 64:28 ID.scala 64:28 ID.scala 95:15]
    reg_aluOp <= mux(reset, UInt<3>("h0"), io_aluOp_in) @[ID.scala 65:32 ID.scala 65:32 ID.scala 89:19]
    reg_regWrite <= mux(reset, UInt<1>("h0"), io_regWrite_in) @[ID.scala 66:35 ID.scala 66:35 ID.scala 90:22]
    reg_operandA <= mux(reset, asSInt(UInt<32>("h0")), io_operandA_in) @[ID.scala 67:35 ID.scala 67:35 ID.scala 85:22]
    reg_operandB <= mux(reset, asSInt(UInt<32>("h0")), io_operandB_in) @[ID.scala 68:35 ID.scala 68:35 ID.scala 86:22]
    reg_rd <= mux(reset, UInt<5>("h0"), io_rd_in) @[ID.scala 69:29 ID.scala 69:29 ID.scala 87:16]
    reg_rs1Ins <= mux(reset, UInt<5>("h0"), io_rs1Ins_in) @[ID.scala 71:33 ID.scala 71:33 ID.scala 91:20]
    reg_rs2Ins <= mux(reset, UInt<5>("h0"), io_rs2Ins_in) @[ID.scala 72:33 ID.scala 72:33 ID.scala 92:20]
    reg_pc <= mux(reset, UInt<32>("h0"), io_pc_in) @[ID.scala 73:29 ID.scala 73:29 ID.scala 96:16]
    reg_pc4 <= mux(reset, UInt<32>("h0"), io_pc4_in) @[ID.scala 74:30 ID.scala 74:30 ID.scala 97:17]
    reg_NextPc <= mux(reset, UInt<2>("h0"), io_NextPc) @[ID.scala 76:33 ID.scala 76:33 ID.scala 99:20]
    reg_imm <= mux(reset, asSInt(UInt<32>("h0")), io_imm) @[ID.scala 77:29 ID.scala 77:29 ID.scala 100:17]

  module EX :
    input clock : Clock
    input reset : UInt<1>
    input io_memWrite_in : UInt<1>
    input io_memRead_in : UInt<1>
    input io_memToReg_in : UInt<1>
    input io_rd_in : UInt<5>
    input io_aluOutput_in : SInt<32>
    input io_regWrite_in : UInt<1>
    input io_offSet_in : SInt<32>
    output io_memWrite_out : UInt<1>
    output io_memRead_out : UInt<1>
    output io_memToReg_out : UInt<1>
    output io_rd_out : UInt<5>
    output io_aluOutput_out : SInt<32>
    output io_regWrite_out : UInt<1>
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
    reg reg_offSet : SInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_offSet) @[EX.scala 38:33]
    io_memWrite_out <= reg_memWrite @[EX.scala 51:21]
    io_memRead_out <= reg_memRead @[EX.scala 52:24]
    io_memToReg_out <= reg_memToReg @[EX.scala 53:25]
    io_rd_out <= reg_rd @[EX.scala 54:19]
    io_aluOutput_out <= reg_aluOutput @[EX.scala 56:26]
    io_regWrite_out <= reg_regWrite @[EX.scala 57:25]
    io_offSet_out <= reg_offSet @[EX.scala 60:23]
    reg_memWrite <= mux(reset, UInt<1>("h0"), io_memWrite_in) @[EX.scala 29:31 EX.scala 29:31 EX.scala 40:22]
    reg_memRead <= mux(reset, UInt<1>("h0"), io_memRead_in) @[EX.scala 30:34 EX.scala 30:34 EX.scala 41:21]
    reg_memToReg <= mux(reset, UInt<1>("h0"), io_memToReg_in) @[EX.scala 31:35 EX.scala 31:35 EX.scala 42:22]
    reg_rd <= mux(reset, UInt<5>("h0"), io_rd_in) @[EX.scala 32:29 EX.scala 32:29 EX.scala 43:16]
    reg_strData <= mux(reset, asSInt(UInt<32>("h0")), reg_strData) @[EX.scala 33:34 EX.scala 33:34 EX.scala 33:34]
    reg_aluOutput <= mux(reset, asSInt(UInt<32>("h0")), io_aluOutput_in) @[EX.scala 34:36 EX.scala 34:36 EX.scala 45:23]
    reg_regWrite <= mux(reset, UInt<1>("h0"), io_regWrite_in) @[EX.scala 35:35 EX.scala 35:35 EX.scala 46:22]
    reg_offSet <= mux(reset, asSInt(UInt<32>("h0")), io_offSet_in) @[EX.scala 38:33 EX.scala 38:33 EX.scala 49:20]

  module MEM_WB :
    input clock : Clock
    input reset : UInt<1>
    input io_memToReg_in : UInt<1>
    input io_rd_in : UInt<5>
    input io_dataOut_in : SInt<32>
    input io_aluOutput_in : SInt<32>
    input io_regWrite_in : UInt<1>
    input io_MemRead_in : UInt<1>
    input io_memWrite_in : UInt<1>
    output io_memToReg_out : UInt<1>
    output io_rd_out : UInt<5>
    output io_dataOut_out : SInt<32>
    output io_aluOutput_out : SInt<32>
    output io_regWrite_out : UInt<1>
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
    io_MemRead_out <= reg_memRead @[Mem_WB.scala 69:24]
    io_memWrite_out <= reg_memWrite @[Mem_WB.scala 70:25]
    reg_memToReg <= mux(reset, UInt<1>("h0"), io_memToReg_in) @[Mem_WB.scala 37:35 Mem_WB.scala 37:35 Mem_WB.scala 49:22]
    reg_rd <= mux(reset, UInt<5>("h0"), io_rd_in) @[Mem_WB.scala 38:29 Mem_WB.scala 38:29 Mem_WB.scala 50:16]
    reg_dataOut <= mux(reset, asSInt(UInt<32>("h0")), io_dataOut_in) @[Mem_WB.scala 39:34 Mem_WB.scala 39:34 Mem_WB.scala 51:21]
    reg_aluOutput <= mux(reset, asSInt(UInt<32>("h0")), io_aluOutput_in) @[Mem_WB.scala 40:36 Mem_WB.scala 40:36 Mem_WB.scala 52:23]
    reg_regWrite <= mux(reset, UInt<1>("h0"), io_regWrite_in) @[Mem_WB.scala 41:35 Mem_WB.scala 41:35 Mem_WB.scala 53:22]
    reg_baseReg <= mux(reset, asSInt(UInt<32>("h0")), reg_baseReg) @[Mem_WB.scala 43:34 Mem_WB.scala 43:34 Mem_WB.scala 43:34]
    reg_offSet <= mux(reset, asSInt(UInt<32>("h0")), reg_offSet) @[Mem_WB.scala 44:33 Mem_WB.scala 44:33 Mem_WB.scala 44:33]
    reg_memRead <= mux(reset, UInt<1>("h0"), io_MemRead_in) @[Mem_WB.scala 45:34 Mem_WB.scala 45:34 Mem_WB.scala 57:21]
    reg_memWrite <= mux(reset, UInt<1>("h0"), io_memWrite_in) @[Mem_WB.scala 46:35 Mem_WB.scala 46:35 Mem_WB.scala 58:22]

  module ForwardUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_EX_MEM_REGRD : UInt<5>
    input io_MEM_WB_REGRD : UInt<5>
    input io_ID_EX_REGRS1 : UInt<5>
    input io_ID_EX_REGRS2 : UInt<5>
    input io_EX_MEM_REGWR : UInt<1>
    input io_MEM_WB_REGWR : UInt<1>
    output io_forward_a : UInt<2>
    output io_forward_b : UInt<2>

    node _T = eq(io_EX_MEM_REGWR, UInt<1>("h1")) @[Frwd.scala 22:26]
    node _T_1 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[Frwd.scala 22:56]
    node _T_2 = and(_T, _T_1) @[Frwd.scala 22:37]
    node _T_3 = eq(io_EX_MEM_REGRD, io_ID_EX_REGRS1) @[Frwd.scala 22:105]
    node _T_4 = and(_T_2, _T_3) @[Frwd.scala 22:71]
    node _T_5 = eq(io_EX_MEM_REGRD, io_ID_EX_REGRS2) @[Frwd.scala 22:146]
    node _T_6 = and(_T_4, _T_5) @[Frwd.scala 22:126]
    node _T_7 = eq(io_EX_MEM_REGWR, UInt<1>("h1")) @[Frwd.scala 25:33]
    node _T_8 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[Frwd.scala 25:63]
    node _T_9 = and(_T_7, _T_8) @[Frwd.scala 25:44]
    node _T_10 = eq(io_EX_MEM_REGRD, io_ID_EX_REGRS2) @[Frwd.scala 25:122]
    node _T_11 = and(_T_9, _T_10) @[Frwd.scala 25:78]
    node _T_12 = eq(io_EX_MEM_REGWR, UInt<1>("h1")) @[Frwd.scala 27:33]
    node _T_13 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[Frwd.scala 27:63]
    node _T_14 = and(_T_12, _T_13) @[Frwd.scala 27:44]
    node _T_15 = eq(io_EX_MEM_REGRD, io_ID_EX_REGRS1) @[Frwd.scala 27:122]
    node _T_16 = and(_T_14, _T_15) @[Frwd.scala 27:78]
    node _GEN_0 = mux(_T_16, UInt<1>("h1"), UInt<1>("h0")) @[Frwd.scala 27:144 Frwd.scala 29:30 Frwd.scala 17:18]
    node _GEN_1 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[Frwd.scala 25:144 Frwd.scala 26:30 Frwd.scala 18:18]
    node _GEN_2 = mux(_T_11, UInt<1>("h0"), _GEN_0) @[Frwd.scala 25:144 Frwd.scala 17:18]
    node _GEN_3 = mux(_T_6, UInt<1>("h1"), _GEN_2) @[Frwd.scala 22:168 Frwd.scala 23:29]
    node _GEN_4 = mux(_T_6, UInt<1>("h1"), _GEN_1) @[Frwd.scala 22:168 Frwd.scala 24:30]
    node _T_17 = eq(io_MEM_WB_REGWR, UInt<1>("h1")) @[Frwd.scala 34:26]
    node _T_18 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[Frwd.scala 34:56]
    node _T_19 = and(_T_17, _T_18) @[Frwd.scala 34:37]
    node _T_20 = eq(io_EX_MEM_REGWR, UInt<1>("h1")) @[Frwd.scala 34:93]
    node _T_21 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[Frwd.scala 34:125]
    node _T_22 = and(_T_20, _T_21) @[Frwd.scala 34:105]
    node _T_23 = eq(io_EX_MEM_REGRD, io_ID_EX_REGRS1) @[Frwd.scala 34:161]
    node _T_24 = and(_T_22, _T_23) @[Frwd.scala 34:141]
    node _T_25 = eq(io_EX_MEM_REGRD, io_ID_EX_REGRS2) @[Frwd.scala 34:202]
    node _T_26 = and(_T_24, _T_25) @[Frwd.scala 34:182]
    node _T_27 = not(_T_26) @[Frwd.scala 34:74]
    node _T_28 = and(_T_19, _T_27) @[Frwd.scala 34:71]
    node _T_29 = eq(io_MEM_WB_REGRD, io_ID_EX_REGRS1) @[Frwd.scala 34:244]
    node _T_30 = and(_T_28, _T_29) @[Frwd.scala 34:224]
    node _T_31 = eq(io_MEM_WB_REGRD, io_ID_EX_REGRS2) @[Frwd.scala 34:285]
    node _T_32 = and(_T_30, _T_31) @[Frwd.scala 34:265]
    node _T_33 = eq(io_MEM_WB_REGWR, UInt<1>("h1")) @[Frwd.scala 39:33]
    node _T_34 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[Frwd.scala 39:63]
    node _T_35 = and(_T_33, _T_34) @[Frwd.scala 39:44]
    node _T_36 = eq(io_EX_MEM_REGWR, UInt<1>("h1")) @[Frwd.scala 39:100]
    node _T_37 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[Frwd.scala 39:132]
    node _T_38 = and(_T_36, _T_37) @[Frwd.scala 39:112]
    node _T_39 = eq(io_EX_MEM_REGRD, io_ID_EX_REGRS2) @[Frwd.scala 39:168]
    node _T_40 = and(_T_38, _T_39) @[Frwd.scala 39:148]
    node _T_41 = not(_T_40) @[Frwd.scala 39:81]
    node _T_42 = and(_T_35, _T_41) @[Frwd.scala 39:78]
    node _T_43 = eq(io_MEM_WB_REGRD, io_ID_EX_REGRS2) @[Frwd.scala 39:210]
    node _T_44 = and(_T_42, _T_43) @[Frwd.scala 39:190]
    node _T_45 = eq(io_MEM_WB_REGWR, UInt<1>("h1")) @[Frwd.scala 43:33]
    node _T_46 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[Frwd.scala 43:63]
    node _T_47 = and(_T_45, _T_46) @[Frwd.scala 43:44]
    node _T_48 = eq(io_EX_MEM_REGWR, UInt<1>("h1")) @[Frwd.scala 43:100]
    node _T_49 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[Frwd.scala 43:132]
    node _T_50 = and(_T_48, _T_49) @[Frwd.scala 43:112]
    node _T_51 = eq(io_EX_MEM_REGRD, io_ID_EX_REGRS2) @[Frwd.scala 43:168]
    node _T_52 = and(_T_50, _T_51) @[Frwd.scala 43:148]
    node _T_53 = not(_T_52) @[Frwd.scala 43:81]
    node _T_54 = and(_T_47, _T_53) @[Frwd.scala 43:78]
    node _T_55 = eq(io_MEM_WB_REGRD, io_ID_EX_REGRS1) @[Frwd.scala 43:211]
    node _T_56 = and(_T_54, _T_55) @[Frwd.scala 43:191]
    node _GEN_5 = mux(_T_56, UInt<2>("h2"), _GEN_3) @[Frwd.scala 43:233 Frwd.scala 44:18]
    node _GEN_6 = mux(_T_44, UInt<2>("h2"), _GEN_4) @[Frwd.scala 39:232 Frwd.scala 41:22]
    node _GEN_7 = mux(_T_44, _GEN_3, _GEN_5) @[Frwd.scala 39:232]
    node _GEN_8 = mux(_T_32, UInt<2>("h2"), _GEN_7) @[Frwd.scala 34:307 Frwd.scala 36:22]
    node _GEN_9 = mux(_T_32, UInt<2>("h2"), _GEN_6) @[Frwd.scala 34:307 Frwd.scala 37:22]
    io_forward_a <= _GEN_8
    io_forward_b <= _GEN_9

  module HazardDetection :
    input clock : Clock
    input reset : UInt<1>
    input io_IF_ID_INST : UInt<32>
    input io_ID_EX_MEMREAD : UInt<1>
    input io_ID_EX_REGRD : UInt<5>
    input io_pc_in : UInt<32>
    input io_current_pc : UInt<32>
    output io_inst_forward : UInt<1>
    output io_pc_forward : UInt<1>
    output io_ctrl_forward : UInt<1>
    output io_inst_out : UInt<32>
    output io_pc_out : UInt<32>
    output io_current_pc_out : UInt<32>

    node rs1_sel = bits(io_IF_ID_INST, 19, 15) @[HazardD.scala 17:30]
    node rs2_sel = bits(io_IF_ID_INST, 24, 20) @[HazardD.scala 18:30]
    node _T = eq(io_ID_EX_MEMREAD, UInt<1>("h1")) @[HazardD.scala 19:25]
    node _T_1 = eq(io_ID_EX_REGRD, rs1_sel) @[HazardD.scala 19:56]
    node _T_2 = eq(io_ID_EX_REGRD, rs2_sel) @[HazardD.scala 19:88]
    node _T_3 = or(_T_1, _T_2) @[HazardD.scala 19:69]
    node _T_4 = and(_T, _T_3) @[HazardD.scala 19:36]
    node _GEN_0 = mux(_T_4, UInt<1>("h1"), UInt<1>("h0")) @[HazardD.scala 19:103 HazardD.scala 20:23 HazardD.scala 28:21]
    node _GEN_1 = mux(_T_4, io_IF_ID_INST, io_IF_ID_INST) @[HazardD.scala 19:103 HazardD.scala 23:19 HazardD.scala 31:17]
    node _GEN_2 = mux(_T_4, io_pc_in, io_pc_in) @[HazardD.scala 19:103 HazardD.scala 24:17 HazardD.scala 32:15]
    node _GEN_3 = mux(_T_4, io_current_pc, io_current_pc) @[HazardD.scala 19:103 HazardD.scala 25:25 HazardD.scala 33:23]
    io_inst_forward <= _GEN_0
    io_pc_forward <= _GEN_0
    io_ctrl_forward <= _GEN_0
    io_inst_out <= _GEN_1
    io_pc_out <= _GEN_2
    io_current_pc_out <= _GEN_3

  module BranchLogic :
    input clock : Clock
    input reset : UInt<1>
    input io_in_rs1 : SInt<32>
    input io_in_rs2 : SInt<32>
    input io_in_func3 : UInt<3>
    output io_output : UInt<1>

    node _T = eq(io_in_func3, UInt<1>("h0")) @[BranchL.scala 13:20]
    node _T_1 = eq(io_in_rs1, io_in_rs2) @[BranchL.scala 15:20]
    node _GEN_0 = mux(_T_1, UInt<1>("h1"), UInt<1>("h0")) @[BranchL.scala 15:35 BranchL.scala 16:17 BranchL.scala 18:17]
    node _T_2 = eq(io_in_func3, UInt<1>("h1")) @[BranchL.scala 20:27]
    node _T_3 = neq(io_in_rs1, io_in_rs2) @[BranchL.scala 22:20]
    node _GEN_1 = mux(_T_3, UInt<1>("h1"), UInt<1>("h0")) @[BranchL.scala 22:35 BranchL.scala 23:17 BranchL.scala 25:17]
    node _T_4 = eq(io_in_func3, UInt<3>("h4")) @[BranchL.scala 27:27]
    node _T_5 = lt(io_in_rs1, io_in_rs2) @[BranchL.scala 29:20]
    node _GEN_2 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[BranchL.scala 29:33 BranchL.scala 30:17 BranchL.scala 32:17]
    node _T_6 = eq(io_in_func3, UInt<3>("h5")) @[BranchL.scala 34:27]
    node _T_7 = geq(io_in_rs1, io_in_rs2) @[BranchL.scala 36:20]
    node _GEN_3 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[BranchL.scala 36:34 BranchL.scala 37:17 BranchL.scala 39:17]
    node _T_8 = eq(io_in_func3, UInt<3>("h6")) @[BranchL.scala 41:27]
    node _T_9 = asUInt(io_in_rs1) @[BranchL.scala 43:20]
    node _T_10 = asUInt(io_in_rs2) @[BranchL.scala 43:39]
    node _T_11 = lt(_T_9, _T_10) @[BranchL.scala 43:27]
    node _GEN_4 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[BranchL.scala 43:47 BranchL.scala 44:17 BranchL.scala 46:17]
    node _T_12 = eq(io_in_func3, UInt<3>("h7")) @[BranchL.scala 48:27]
    node _T_13 = asUInt(io_in_rs1) @[BranchL.scala 50:20]
    node _T_14 = asUInt(io_in_rs2) @[BranchL.scala 50:40]
    node _T_15 = geq(_T_13, _T_14) @[BranchL.scala 50:27]
    node _GEN_5 = mux(_T_15, UInt<1>("h1"), UInt<1>("h0")) @[BranchL.scala 50:48 BranchL.scala 51:17 BranchL.scala 53:17]
    node _GEN_6 = mux(_T_12, _GEN_5, UInt<1>("h0")) @[BranchL.scala 48:41 BranchL.scala 56:15]
    node _GEN_7 = mux(_T_8, _GEN_4, _GEN_6) @[BranchL.scala 41:41]
    node _GEN_8 = mux(_T_6, _GEN_3, _GEN_7) @[BranchL.scala 34:41]
    node _GEN_9 = mux(_T_4, _GEN_2, _GEN_8) @[BranchL.scala 27:41]
    node _GEN_10 = mux(_T_2, _GEN_1, _GEN_9) @[BranchL.scala 20:41]
    node _GEN_11 = mux(_T, _GEN_0, _GEN_10) @[BranchL.scala 13:34]
    io_output <= _GEN_11

  module DecodeBranchForward :
    input clock : Clock
    input reset : UInt<1>
    input io_ID_EX_REGRD : UInt<5>
    input io_ID_EX_MEMRD : UInt<1>
    input io_EX_MEM_REGRD : UInt<5>
    input io_EX_MEM_MEMRD : UInt<1>
    input io_MEM_WB_REGRD : UInt<5>
    input io_MEM_WB_MEMRD : UInt<1>
    input io_rs1_sel : UInt<5>
    input io_rs2_sel : UInt<5>
    input io_ctrl_branch : UInt<1>
    output io_forward_rs1 : UInt<4>
    output io_forward_rs2 : UInt<4>

    node _T = eq(io_ctrl_branch, UInt<1>("h1")) @[BranchF.scala 21:21]
    node _T_1 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 23:23]
    node _T_2 = neq(io_ID_EX_MEMRD, UInt<1>("h1")) @[BranchF.scala 23:56]
    node _T_3 = and(_T_1, _T_2) @[BranchF.scala 23:38]
    node _T_4 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 23:83]
    node _T_5 = and(_T_3, _T_4) @[BranchF.scala 23:64]
    node _T_6 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 23:118]
    node _T_7 = and(_T_5, _T_6) @[BranchF.scala 23:99]
    node _T_8 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 26:30]
    node _T_9 = neq(io_ID_EX_MEMRD, UInt<1>("h1")) @[BranchF.scala 26:63]
    node _T_10 = and(_T_8, _T_9) @[BranchF.scala 26:45]
    node _T_11 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 26:90]
    node _T_12 = and(_T_10, _T_11) @[BranchF.scala 26:71]
    node _T_13 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 28:30]
    node _T_14 = neq(io_ID_EX_MEMRD, UInt<1>("h1")) @[BranchF.scala 28:63]
    node _T_15 = and(_T_13, _T_14) @[BranchF.scala 28:45]
    node _T_16 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 28:90]
    node _T_17 = and(_T_15, _T_16) @[BranchF.scala 28:71]
    node _GEN_0 = mux(_T_17, UInt<1>("h1"), UInt<1>("h0")) @[BranchF.scala 28:107 BranchF.scala 29:20 BranchF.scala 20:20]
    node _GEN_1 = mux(_T_12, UInt<1>("h1"), UInt<1>("h0")) @[BranchF.scala 26:107 BranchF.scala 27:20 BranchF.scala 19:20]
    node _GEN_2 = mux(_T_12, UInt<1>("h0"), _GEN_0) @[BranchF.scala 26:107 BranchF.scala 20:20]
    node _GEN_3 = mux(_T_7, UInt<1>("h1"), _GEN_1) @[BranchF.scala 23:135 BranchF.scala 24:20]
    node _GEN_4 = mux(_T_7, UInt<1>("h1"), _GEN_2) @[BranchF.scala 23:135 BranchF.scala 25:20]
    node _T_18 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 33:24]
    node _T_19 = neq(io_EX_MEM_MEMRD, UInt<1>("h1")) @[BranchF.scala 33:58]
    node _T_20 = and(_T_18, _T_19) @[BranchF.scala 33:39]
    node _T_21 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 34:23]
    node _T_22 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 34:58]
    node _T_23 = and(_T_21, _T_22) @[BranchF.scala 34:39]
    node _T_24 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 34:93]
    node _T_25 = and(_T_23, _T_24) @[BranchF.scala 34:74]
    node _T_26 = not(_T_25) @[BranchF.scala 34:5]
    node _T_27 = and(_T_20, _T_26) @[BranchF.scala 33:66]
    node _T_28 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 35:22]
    node _T_29 = and(_T_27, _T_28) @[BranchF.scala 34:110]
    node _T_30 = eq(io_EX_MEM_REGRD, io_rs2_sel) @[BranchF.scala 35:58]
    node _T_31 = and(_T_29, _T_30) @[BranchF.scala 35:38]
    node _T_32 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 40:31]
    node _T_33 = neq(io_EX_MEM_MEMRD, UInt<1>("h1")) @[BranchF.scala 40:65]
    node _T_34 = and(_T_32, _T_33) @[BranchF.scala 40:46]
    node _T_35 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 41:23]
    node _T_36 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 41:58]
    node _T_37 = and(_T_35, _T_36) @[BranchF.scala 41:39]
    node _T_38 = not(_T_37) @[BranchF.scala 41:5]
    node _T_39 = and(_T_34, _T_38) @[BranchF.scala 40:73]
    node _T_40 = eq(io_EX_MEM_REGRD, io_rs2_sel) @[BranchF.scala 42:22]
    node _T_41 = and(_T_39, _T_40) @[BranchF.scala 41:75]
    node _T_42 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 46:31]
    node _T_43 = neq(io_EX_MEM_MEMRD, UInt<1>("h1")) @[BranchF.scala 46:65]
    node _T_44 = and(_T_42, _T_43) @[BranchF.scala 46:46]
    node _T_45 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 47:23]
    node _T_46 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 47:58]
    node _T_47 = and(_T_45, _T_46) @[BranchF.scala 47:39]
    node _T_48 = not(_T_47) @[BranchF.scala 47:5]
    node _T_49 = and(_T_44, _T_48) @[BranchF.scala 46:73]
    node _T_50 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 48:22]
    node _T_51 = and(_T_49, _T_50) @[BranchF.scala 47:75]
    node _T_52 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 52:31]
    node _T_53 = eq(io_EX_MEM_MEMRD, UInt<1>("h1")) @[BranchF.scala 52:65]
    node _T_54 = and(_T_52, _T_53) @[BranchF.scala 52:46]
    node _T_55 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 53:23]
    node _T_56 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 53:58]
    node _T_57 = and(_T_55, _T_56) @[BranchF.scala 53:39]
    node _T_58 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 53:93]
    node _T_59 = and(_T_57, _T_58) @[BranchF.scala 53:74]
    node _T_60 = not(_T_59) @[BranchF.scala 53:5]
    node _T_61 = and(_T_54, _T_60) @[BranchF.scala 52:73]
    node _T_62 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 54:22]
    node _T_63 = and(_T_61, _T_62) @[BranchF.scala 53:110]
    node _T_64 = eq(io_EX_MEM_REGRD, io_rs2_sel) @[BranchF.scala 54:58]
    node _T_65 = and(_T_63, _T_64) @[BranchF.scala 54:38]
    node _T_66 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 59:31]
    node _T_67 = eq(io_EX_MEM_MEMRD, UInt<1>("h1")) @[BranchF.scala 59:65]
    node _T_68 = and(_T_66, _T_67) @[BranchF.scala 59:46]
    node _T_69 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 60:23]
    node _T_70 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 60:58]
    node _T_71 = and(_T_69, _T_70) @[BranchF.scala 60:39]
    node _T_72 = not(_T_71) @[BranchF.scala 60:5]
    node _T_73 = and(_T_68, _T_72) @[BranchF.scala 59:73]
    node _T_74 = eq(io_EX_MEM_REGRD, io_rs2_sel) @[BranchF.scala 61:22]
    node _T_75 = and(_T_73, _T_74) @[BranchF.scala 60:75]
    node _T_76 = eq(io_ctrl_branch, UInt<1>("h1")) @[BranchF.scala 65:30]
    node _T_77 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 65:57]
    node _T_78 = and(_T_76, _T_77) @[BranchF.scala 65:38]
    node _T_79 = eq(io_EX_MEM_MEMRD, UInt<1>("h1")) @[BranchF.scala 65:91]
    node _T_80 = and(_T_78, _T_79) @[BranchF.scala 65:72]
    node _T_81 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 66:23]
    node _T_82 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 66:58]
    node _T_83 = and(_T_81, _T_82) @[BranchF.scala 66:39]
    node _T_84 = not(_T_83) @[BranchF.scala 66:5]
    node _T_85 = and(_T_80, _T_84) @[BranchF.scala 65:99]
    node _T_86 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 67:22]
    node _T_87 = and(_T_85, _T_86) @[BranchF.scala 66:75]
    node _GEN_5 = mux(_T_87, UInt<3>("h4"), _GEN_3) @[BranchF.scala 67:39 BranchF.scala 69:20]
    node _GEN_6 = mux(_T_75, UInt<3>("h4"), _GEN_4) @[BranchF.scala 61:39 BranchF.scala 63:20]
    node _GEN_7 = mux(_T_75, _GEN_3, _GEN_5) @[BranchF.scala 61:39]
    node _GEN_8 = mux(_T_65, UInt<3>("h4"), _GEN_7) @[BranchF.scala 54:75 BranchF.scala 56:20]
    node _GEN_9 = mux(_T_65, UInt<3>("h4"), _GEN_6) @[BranchF.scala 54:75 BranchF.scala 57:20]
    node _GEN_10 = mux(_T_51, UInt<2>("h2"), _GEN_8) @[BranchF.scala 48:39 BranchF.scala 50:20]
    node _GEN_11 = mux(_T_51, _GEN_4, _GEN_9) @[BranchF.scala 48:39]
    node _GEN_12 = mux(_T_41, UInt<2>("h2"), _GEN_11) @[BranchF.scala 42:39 BranchF.scala 44:20]
    node _GEN_13 = mux(_T_41, _GEN_3, _GEN_10) @[BranchF.scala 42:39]
    node _GEN_14 = mux(_T_31, UInt<2>("h2"), _GEN_13) @[BranchF.scala 35:75 BranchF.scala 37:20]
    node _GEN_15 = mux(_T_31, UInt<2>("h2"), _GEN_12) @[BranchF.scala 35:75 BranchF.scala 38:20]
    node _T_88 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[BranchF.scala 74:24]
    node _T_89 = neq(io_MEM_WB_MEMRD, UInt<1>("h1")) @[BranchF.scala 74:58]
    node _T_90 = and(_T_88, _T_89) @[BranchF.scala 74:39]
    node _T_91 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 76:23]
    node _T_92 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 76:58]
    node _T_93 = and(_T_91, _T_92) @[BranchF.scala 76:39]
    node _T_94 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 76:93]
    node _T_95 = and(_T_93, _T_94) @[BranchF.scala 76:74]
    node _T_96 = not(_T_95) @[BranchF.scala 76:5]
    node _T_97 = and(_T_90, _T_96) @[BranchF.scala 74:66]
    node _T_98 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 78:24]
    node _T_99 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 78:60]
    node _T_100 = and(_T_98, _T_99) @[BranchF.scala 78:40]
    node _T_101 = eq(io_EX_MEM_REGRD, io_rs2_sel) @[BranchF.scala 78:96]
    node _T_102 = and(_T_100, _T_101) @[BranchF.scala 78:76]
    node _T_103 = not(_T_102) @[BranchF.scala 78:5]
    node _T_104 = and(_T_97, _T_103) @[BranchF.scala 76:110]
    node _T_105 = eq(io_MEM_WB_REGRD, io_rs1_sel) @[BranchF.scala 79:22]
    node _T_106 = and(_T_104, _T_105) @[BranchF.scala 78:113]
    node _T_107 = eq(io_MEM_WB_REGRD, io_rs2_sel) @[BranchF.scala 79:58]
    node _T_108 = and(_T_106, _T_107) @[BranchF.scala 79:38]
    node _T_109 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[BranchF.scala 85:31]
    node _T_110 = neq(io_MEM_WB_MEMRD, UInt<1>("h1")) @[BranchF.scala 85:65]
    node _T_111 = and(_T_109, _T_110) @[BranchF.scala 85:46]
    node _T_112 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 87:25]
    node _T_113 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 87:60]
    node _T_114 = and(_T_112, _T_113) @[BranchF.scala 87:41]
    node _T_115 = not(_T_114) @[BranchF.scala 87:7]
    node _T_116 = and(_T_111, _T_115) @[BranchF.scala 85:73]
    node _T_117 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 89:26]
    node _T_118 = eq(io_EX_MEM_REGRD, io_rs2_sel) @[BranchF.scala 89:62]
    node _T_119 = and(_T_117, _T_118) @[BranchF.scala 89:42]
    node _T_120 = not(_T_119) @[BranchF.scala 89:7]
    node _T_121 = and(_T_116, _T_120) @[BranchF.scala 87:77]
    node _T_122 = eq(io_MEM_WB_REGRD, io_rs2_sel) @[BranchF.scala 90:24]
    node _T_123 = and(_T_121, _T_122) @[BranchF.scala 89:79]
    node _T_124 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[BranchF.scala 95:31]
    node _T_125 = neq(io_MEM_WB_MEMRD, UInt<1>("h1")) @[BranchF.scala 95:65]
    node _T_126 = and(_T_124, _T_125) @[BranchF.scala 95:46]
    node _T_127 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 97:25]
    node _T_128 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 97:60]
    node _T_129 = and(_T_127, _T_128) @[BranchF.scala 97:41]
    node _T_130 = not(_T_129) @[BranchF.scala 97:7]
    node _T_131 = and(_T_126, _T_130) @[BranchF.scala 95:73]
    node _T_132 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 99:26]
    node _T_133 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 99:62]
    node _T_134 = and(_T_132, _T_133) @[BranchF.scala 99:42]
    node _T_135 = not(_T_134) @[BranchF.scala 99:7]
    node _T_136 = and(_T_131, _T_135) @[BranchF.scala 97:77]
    node _T_137 = eq(io_MEM_WB_REGRD, io_rs1_sel) @[BranchF.scala 100:24]
    node _T_138 = and(_T_136, _T_137) @[BranchF.scala 99:79]
    node _T_139 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[BranchF.scala 104:33]
    node _T_140 = eq(io_MEM_WB_MEMRD, UInt<1>("h1")) @[BranchF.scala 104:67]
    node _T_141 = and(_T_139, _T_140) @[BranchF.scala 104:48]
    node _T_142 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 106:23]
    node _T_143 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 106:58]
    node _T_144 = and(_T_142, _T_143) @[BranchF.scala 106:39]
    node _T_145 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 106:93]
    node _T_146 = and(_T_144, _T_145) @[BranchF.scala 106:74]
    node _T_147 = not(_T_146) @[BranchF.scala 106:5]
    node _T_148 = and(_T_141, _T_147) @[BranchF.scala 104:75]
    node _T_149 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 108:24]
    node _T_150 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 108:60]
    node _T_151 = and(_T_149, _T_150) @[BranchF.scala 108:40]
    node _T_152 = eq(io_EX_MEM_REGRD, io_rs2_sel) @[BranchF.scala 108:96]
    node _T_153 = and(_T_151, _T_152) @[BranchF.scala 108:76]
    node _T_154 = not(_T_153) @[BranchF.scala 108:5]
    node _T_155 = and(_T_148, _T_154) @[BranchF.scala 106:110]
    node _T_156 = eq(io_MEM_WB_REGRD, io_rs1_sel) @[BranchF.scala 109:22]
    node _T_157 = and(_T_155, _T_156) @[BranchF.scala 108:113]
    node _T_158 = eq(io_MEM_WB_REGRD, io_rs2_sel) @[BranchF.scala 109:58]
    node _T_159 = and(_T_157, _T_158) @[BranchF.scala 109:38]
    node _T_160 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[BranchF.scala 115:31]
    node _T_161 = eq(io_MEM_WB_MEMRD, UInt<1>("h1")) @[BranchF.scala 115:65]
    node _T_162 = and(_T_160, _T_161) @[BranchF.scala 115:46]
    node _T_163 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 117:25]
    node _T_164 = eq(io_ID_EX_REGRD, io_rs2_sel) @[BranchF.scala 117:60]
    node _T_165 = and(_T_163, _T_164) @[BranchF.scala 117:41]
    node _T_166 = not(_T_165) @[BranchF.scala 117:7]
    node _T_167 = and(_T_162, _T_166) @[BranchF.scala 115:73]
    node _T_168 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 119:26]
    node _T_169 = eq(io_EX_MEM_REGRD, io_rs2_sel) @[BranchF.scala 119:62]
    node _T_170 = and(_T_168, _T_169) @[BranchF.scala 119:42]
    node _T_171 = not(_T_170) @[BranchF.scala 119:7]
    node _T_172 = and(_T_167, _T_171) @[BranchF.scala 117:77]
    node _T_173 = eq(io_MEM_WB_REGRD, io_rs2_sel) @[BranchF.scala 120:24]
    node _T_174 = and(_T_172, _T_173) @[BranchF.scala 119:79]
    node _T_175 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[BranchF.scala 125:31]
    node _T_176 = eq(io_MEM_WB_MEMRD, UInt<1>("h1")) @[BranchF.scala 125:65]
    node _T_177 = and(_T_175, _T_176) @[BranchF.scala 125:46]
    node _T_178 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 127:25]
    node _T_179 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 127:60]
    node _T_180 = and(_T_178, _T_179) @[BranchF.scala 127:41]
    node _T_181 = not(_T_180) @[BranchF.scala 127:7]
    node _T_182 = and(_T_177, _T_181) @[BranchF.scala 125:73]
    node _T_183 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 129:26]
    node _T_184 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 129:62]
    node _T_185 = and(_T_183, _T_184) @[BranchF.scala 129:42]
    node _T_186 = not(_T_185) @[BranchF.scala 129:7]
    node _T_187 = and(_T_182, _T_186) @[BranchF.scala 127:77]
    node _T_188 = eq(io_MEM_WB_REGRD, io_rs1_sel) @[BranchF.scala 130:24]
    node _T_189 = and(_T_187, _T_188) @[BranchF.scala 129:78]
    node _GEN_16 = mux(_T_189, UInt<3>("h5"), _GEN_14) @[BranchF.scala 130:41 BranchF.scala 132:22]
    node _GEN_17 = mux(_T_174, UInt<3>("h5"), _GEN_15) @[BranchF.scala 120:41 BranchF.scala 122:22]
    node _GEN_18 = mux(_T_174, _GEN_14, _GEN_16) @[BranchF.scala 120:41]
    node _GEN_19 = mux(_T_159, UInt<3>("h5"), _GEN_18) @[BranchF.scala 109:75 BranchF.scala 111:20]
    node _GEN_20 = mux(_T_159, UInt<3>("h5"), _GEN_17) @[BranchF.scala 109:75 BranchF.scala 112:20]
    node _GEN_21 = mux(_T_138, UInt<2>("h3"), _GEN_19) @[BranchF.scala 100:41 BranchF.scala 102:22]
    node _GEN_22 = mux(_T_138, _GEN_15, _GEN_20) @[BranchF.scala 100:41]
    node _GEN_23 = mux(_T_123, UInt<2>("h3"), _GEN_22) @[BranchF.scala 90:41 BranchF.scala 92:22]
    node _GEN_24 = mux(_T_123, _GEN_14, _GEN_21) @[BranchF.scala 90:41]
    node _GEN_25 = mux(_T_108, UInt<2>("h3"), _GEN_24) @[BranchF.scala 79:75 BranchF.scala 81:20]
    node _GEN_26 = mux(_T_108, UInt<2>("h3"), _GEN_23) @[BranchF.scala 79:75 BranchF.scala 82:20]
    node _T_190 = eq(io_ctrl_branch, UInt<1>("h0")) @[BranchF.scala 137:26]
    node _T_191 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 139:29]
    node _T_192 = neq(io_ID_EX_MEMRD, UInt<1>("h1")) @[BranchF.scala 139:62]
    node _T_193 = and(_T_191, _T_192) @[BranchF.scala 139:44]
    node _T_194 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 139:89]
    node _T_195 = and(_T_193, _T_194) @[BranchF.scala 139:70]
    node _GEN_27 = mux(_T_195, UInt<3>("h6"), UInt<1>("h0")) @[BranchF.scala 139:109 BranchF.scala 140:26 BranchF.scala 19:20]
    node _T_196 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 144:30]
    node _T_197 = neq(io_EX_MEM_MEMRD, UInt<1>("h1")) @[BranchF.scala 144:64]
    node _T_198 = and(_T_196, _T_197) @[BranchF.scala 144:45]
    node _T_199 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 145:29]
    node _T_200 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 145:64]
    node _T_201 = and(_T_199, _T_200) @[BranchF.scala 145:45]
    node _T_202 = not(_T_201) @[BranchF.scala 145:11]
    node _T_203 = and(_T_198, _T_202) @[BranchF.scala 144:72]
    node _T_204 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 146:28]
    node _T_205 = and(_T_203, _T_204) @[BranchF.scala 145:81]
    node _T_206 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 151:37]
    node _T_207 = eq(io_EX_MEM_MEMRD, UInt<1>("h1")) @[BranchF.scala 151:71]
    node _T_208 = and(_T_206, _T_207) @[BranchF.scala 151:52]
    node _T_209 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 152:31]
    node _T_210 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 152:66]
    node _T_211 = and(_T_209, _T_210) @[BranchF.scala 152:47]
    node _T_212 = not(_T_211) @[BranchF.scala 152:13]
    node _T_213 = and(_T_208, _T_212) @[BranchF.scala 151:79]
    node _T_214 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 153:30]
    node _T_215 = and(_T_213, _T_214) @[BranchF.scala 152:83]
    node _GEN_28 = mux(_T_215, UInt<4>("h9"), _GEN_27) @[BranchF.scala 153:47 BranchF.scala 155:28]
    node _GEN_29 = mux(_T_205, UInt<3>("h7"), _GEN_28) @[BranchF.scala 146:45 BranchF.scala 148:26]
    node _T_216 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[BranchF.scala 161:30]
    node _T_217 = neq(io_MEM_WB_MEMRD, UInt<1>("h1")) @[BranchF.scala 161:64]
    node _T_218 = and(_T_216, _T_217) @[BranchF.scala 161:45]
    node _T_219 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 163:29]
    node _T_220 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 163:64]
    node _T_221 = and(_T_219, _T_220) @[BranchF.scala 163:45]
    node _T_222 = not(_T_221) @[BranchF.scala 163:11]
    node _T_223 = and(_T_218, _T_222) @[BranchF.scala 161:72]
    node _T_224 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 165:30]
    node _T_225 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 165:66]
    node _T_226 = and(_T_224, _T_225) @[BranchF.scala 165:46]
    node _T_227 = not(_T_226) @[BranchF.scala 165:11]
    node _T_228 = and(_T_223, _T_227) @[BranchF.scala 163:81]
    node _T_229 = eq(io_MEM_WB_REGRD, io_rs1_sel) @[BranchF.scala 166:28]
    node _T_230 = and(_T_228, _T_229) @[BranchF.scala 165:83]
    node _T_231 = neq(io_MEM_WB_REGRD, UInt<1>("h0")) @[BranchF.scala 171:38]
    node _T_232 = eq(io_MEM_WB_MEMRD, UInt<1>("h1")) @[BranchF.scala 171:72]
    node _T_233 = and(_T_231, _T_232) @[BranchF.scala 171:53]
    node _T_234 = neq(io_ID_EX_REGRD, UInt<1>("h0")) @[BranchF.scala 173:29]
    node _T_235 = eq(io_ID_EX_REGRD, io_rs1_sel) @[BranchF.scala 173:64]
    node _T_236 = and(_T_234, _T_235) @[BranchF.scala 173:45]
    node _T_237 = not(_T_236) @[BranchF.scala 173:11]
    node _T_238 = and(_T_233, _T_237) @[BranchF.scala 171:80]
    node _T_239 = neq(io_EX_MEM_REGRD, UInt<1>("h0")) @[BranchF.scala 175:30]
    node _T_240 = eq(io_EX_MEM_REGRD, io_rs1_sel) @[BranchF.scala 175:66]
    node _T_241 = and(_T_239, _T_240) @[BranchF.scala 175:46]
    node _T_242 = not(_T_241) @[BranchF.scala 175:11]
    node _T_243 = and(_T_238, _T_242) @[BranchF.scala 173:81]
    node _T_244 = eq(io_MEM_WB_REGRD, io_rs1_sel) @[BranchF.scala 176:28]
    node _T_245 = and(_T_243, _T_244) @[BranchF.scala 175:83]
    node _GEN_30 = mux(_T_245, UInt<4>("ha"), _GEN_29) @[BranchF.scala 176:45 BranchF.scala 178:26]
    node _GEN_31 = mux(_T_230, UInt<4>("h8"), _GEN_30) @[BranchF.scala 166:45 BranchF.scala 168:26]
    node _GEN_32 = mux(_T_190, _GEN_31, UInt<1>("h0")) @[BranchF.scala 137:35 BranchF.scala 19:20]
    node _GEN_33 = mux(_T, _GEN_25, _GEN_32) @[BranchF.scala 21:30]
    node _GEN_34 = mux(_T, _GEN_26, UInt<1>("h0")) @[BranchF.scala 21:30 BranchF.scala 20:20]
    io_forward_rs1 <= _GEN_33
    io_forward_rs2 <= _GEN_34

  module StructuralDetector :
    input clock : Clock
    input reset : UInt<1>
    input io_rs1_sel : UInt<5>
    input io_rs2_sel : UInt<5>
    input io_MEM_WB_regWr : UInt<1>
    input io_MEM_WB_REGRD : UInt<5>
    output io_fwd_rs1 : UInt<1>
    output io_fwd_rs2 : UInt<1>

    node _T = eq(io_MEM_WB_regWr, UInt<1>("h1")) @[STD.scala 13:24]
    node _T_1 = eq(io_MEM_WB_REGRD, io_rs1_sel) @[STD.scala 13:52]
    node _T_2 = and(_T, _T_1) @[STD.scala 13:32]
    node _GEN_0 = mux(_T_2, UInt<1>("h1"), UInt<1>("h0")) @[STD.scala 13:68 STD.scala 14:16 STD.scala 16:16]
    node _T_3 = eq(io_MEM_WB_regWr, UInt<1>("h1")) @[STD.scala 18:24]
    node _T_4 = eq(io_MEM_WB_REGRD, io_rs2_sel) @[STD.scala 18:51]
    node _T_5 = and(_T_3, _T_4) @[STD.scala 18:32]
    node _GEN_1 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[STD.scala 18:67 STD.scala 19:16 STD.scala 21:16]
    io_fwd_rs1 <= _GEN_0
    io_fwd_rs2 <= _GEN_1

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
    inst imm of ImmdValGen1 @[top.scala 23:20]
    inst Jalr of jalr @[top.scala 24:22]
    inst alu_cnt of alu_controler @[top.scala 25:24]
    inst IF of Inst_fetch @[top.scala 28:18]
    inst ID of ID @[top.scala 29:19]
    inst EX of EX @[top.scala 30:19]
    inst Mem_wb of MEM_WB @[top.scala 31:22]
    inst Forward_U of ForwardUnit @[top.scala 34:25]
    inst HD of HazardDetection @[top.scala 35:18]
    inst BL of BranchLogic @[top.scala 36:18]
    inst BF of DecodeBranchForward @[top.scala 37:18]
    inst SD of StructuralDetector @[top.scala 38:18]
    node _inst_mem_io_addr_T = bits(pc.io_pc_out, 11, 2) @[top.scala 51:35]
    node _controler_io_opcod_T = bits(IF.io_ins_out, 6, 0) @[top.scala 59:38]
    node _reg_file_io_rs1_T = bits(IF.io_ins_out, 19, 15) @[top.scala 60:35]
    node _reg_file_io_rs2_T = bits(IF.io_ins_out, 24, 20) @[top.scala 61:35]
    node _SD_io_rs1_sel_T = bits(IF.io_ins_out, 19, 15) @[top.scala 86:35]
    node _SD_io_rs2_sel_T = bits(IF.io_ins_out, 24, 20) @[top.scala 87:35]
    node _T = eq(SD.io_fwd_rs1, UInt<1>("h1")) @[top.scala 93:24]
    node _GEN_0 = mux(_T, reg_file.io_WriteData, reg_file.io_rd1) @[top.scala 93:33 top.scala 94:23 top.scala 96:23]
    node _T_1 = eq(SD.io_fwd_rs2, UInt<1>("h1")) @[top.scala 99:24]
    node _GEN_1 = mux(_T_1, reg_file.io_WriteData, reg_file.io_rd2) @[top.scala 99:33 top.scala 100:23 top.scala 102:23]
    node _T_2 = eq(HD.io_ctrl_forward, UInt<1>("h1")) @[top.scala 106:29]
    node _GEN_2 = mux(_T_2, UInt<1>("h0"), controler.io_memwrite) @[top.scala 106:41 top.scala 107:27 top.scala 118:23]
    node _GEN_3 = mux(_T_2, UInt<1>("h0"), controler.io_memread) @[top.scala 106:41 top.scala 108:26 top.scala 119:22]
    node _GEN_4 = mux(_T_2, UInt<1>("h0"), controler.io_branch) @[top.scala 106:41 top.scala 109:24 top.scala 120:21]
    node _GEN_5 = mux(_T_2, UInt<1>("h0"), controler.io_regwrite) @[top.scala 106:41 top.scala 110:27 top.scala 121:23]
    node _GEN_6 = mux(_T_2, UInt<1>("h0"), controler.io_memtoreg) @[top.scala 106:41 top.scala 111:27 top.scala 122:23]
    node _GEN_7 = mux(_T_2, UInt<1>("h0"), controler.io_aluop) @[top.scala 106:41 top.scala 112:24 top.scala 123:19]
    node _GEN_8 = mux(_T_2, UInt<1>("h0"), controler.io_op_a) @[top.scala 106:41 top.scala 113:30 top.scala 124:26]
    node _GEN_9 = mux(_T_2, UInt<1>("h0"), controler.io_op_b) @[top.scala 106:41 top.scala 114:30 top.scala 125:26]
    node _GEN_10 = mux(_T_2, UInt<1>("h0"), controler.io_next_pc) @[top.scala 106:41 top.scala 115:22 top.scala 126:18]
    node _ID_io_imm_T = eq(UInt<1>("h0"), controler.io_extend_sel) @[Mux.scala 80:60]
    node _ID_io_imm_T_1 = mux(_ID_io_imm_T, imm.io_i_imm, asSInt(UInt<1>("h0"))) @[Mux.scala 80:57]
    node _ID_io_imm_T_2 = eq(UInt<1>("h1"), controler.io_extend_sel) @[Mux.scala 80:60]
    node _ID_io_imm_T_3 = mux(_ID_io_imm_T_2, imm.io_s_imm, _ID_io_imm_T_1) @[Mux.scala 80:57]
    node _ID_io_imm_T_4 = eq(UInt<2>("h2"), controler.io_extend_sel) @[Mux.scala 80:60]
    node _ID_io_imm_T_5 = mux(_ID_io_imm_T_4, imm.io_u_imm, _ID_io_imm_T_3) @[Mux.scala 80:57]
    node _BF_io_rs1_sel_T = bits(IF.io_ins_out, 19, 15) @[top.scala 147:35]
    node _BF_io_rs2_sel_T = bits(IF.io_ins_out, 24, 20) @[top.scala 148:35]
    node _BL_io_in_func3_T = bits(IF.io_ins_out, 14, 12) @[top.scala 154:36]
    node _T_3 = eq(UInt<1>("h0"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_4 = eq(UInt<1>("h1"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_5 = eq(UInt<2>("h2"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_6 = eq(UInt<2>("h3"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_7 = eq(UInt<3>("h4"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_8 = eq(UInt<3>("h5"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_9 = eq(UInt<3>("h6"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_10 = eq(UInt<3>("h7"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_11 = eq(UInt<4>("h8"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_12 = eq(UInt<4>("h9"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _T_13 = eq(UInt<4>("ha"), BF.io_forward_rs1) @[Conditional.scala 37:30]
    node _GEN_11 = mux(_T_13, reg_file.io_WriteData, reg_file.io_rd1) @[Conditional.scala 39:67 top.scala 202:26 top.scala 156:17]
    node _GEN_12 = mux(_T_13, reg_file.io_rd1, reg_file.io_rd1) @[Conditional.scala 39:67 top.scala 203:26 top.scala 152:18]
    node _GEN_13 = mux(_T_12, data_mem.io_out, _GEN_11) @[Conditional.scala 39:67 top.scala 198:26]
    node _GEN_14 = mux(_T_12, reg_file.io_rd1, _GEN_12) @[Conditional.scala 39:67 top.scala 199:26]
    node _GEN_15 = mux(_T_11, reg_file.io_WriteData, _GEN_13) @[Conditional.scala 39:67 top.scala 194:26]
    node _GEN_16 = mux(_T_11, reg_file.io_rd1, _GEN_14) @[Conditional.scala 39:67 top.scala 195:25]
    node _GEN_17 = mux(_T_10, EX.io_aluOutput_out, _GEN_15) @[Conditional.scala 39:67 top.scala 190:26]
    node _GEN_18 = mux(_T_10, reg_file.io_rd1, _GEN_16) @[Conditional.scala 39:67 top.scala 191:26]
    node _GEN_19 = mux(_T_9, alu.io_out, _GEN_17) @[Conditional.scala 39:67 top.scala 186:26]
    node _GEN_20 = mux(_T_9, reg_file.io_rd1, _GEN_18) @[Conditional.scala 39:67 top.scala 187:26]
    node _GEN_21 = mux(_T_8, reg_file.io_WriteData, _GEN_20) @[Conditional.scala 39:67 top.scala 182:25]
    node _GEN_22 = mux(_T_8, reg_file.io_rd1, _GEN_19) @[Conditional.scala 39:67 top.scala 183:26]
    node _GEN_23 = mux(_T_7, data_mem.io_out, _GEN_21) @[Conditional.scala 39:67 top.scala 178:26]
    node _GEN_24 = mux(_T_7, reg_file.io_rd1, _GEN_22) @[Conditional.scala 39:67 top.scala 179:26]
    node _GEN_25 = mux(_T_6, reg_file.io_WriteData, _GEN_23) @[Conditional.scala 39:67 top.scala 174:26]
    node _GEN_26 = mux(_T_6, reg_file.io_rd1, _GEN_24) @[Conditional.scala 39:67 top.scala 175:26]
    node _GEN_27 = mux(_T_5, EX.io_aluOutput_out, _GEN_25) @[Conditional.scala 39:67 top.scala 170:26]
    node _GEN_28 = mux(_T_5, reg_file.io_rd1, _GEN_26) @[Conditional.scala 39:67 top.scala 171:26]
    node _GEN_29 = mux(_T_4, alu.io_out, _GEN_27) @[Conditional.scala 39:67 top.scala 166:26]
    node _GEN_30 = mux(_T_4, reg_file.io_rd1, _GEN_28) @[Conditional.scala 39:67 top.scala 167:25]
    node _GEN_31 = mux(_T_3, reg_file.io_rd1, _GEN_29) @[Conditional.scala 40:58 top.scala 162:26]
    node _GEN_32 = mux(_T_3, reg_file.io_rd1, _GEN_30) @[Conditional.scala 40:58 top.scala 163:26]
    node _T_14 = eq(UInt<1>("h0"), BF.io_forward_rs2) @[Conditional.scala 37:30]
    node _T_15 = eq(UInt<1>("h1"), BF.io_forward_rs2) @[Conditional.scala 37:30]
    node _T_16 = eq(UInt<2>("h2"), BF.io_forward_rs2) @[Conditional.scala 37:30]
    node _T_17 = eq(UInt<2>("h3"), BF.io_forward_rs2) @[Conditional.scala 37:30]
    node _T_18 = eq(UInt<3>("h4"), BF.io_forward_rs2) @[Conditional.scala 37:30]
    node _T_19 = eq(UInt<3>("h5"), BF.io_forward_rs2) @[Conditional.scala 37:30]
    node _GEN_33 = mux(_T_19, reg_file.io_WriteData, reg_file.io_rd2) @[Conditional.scala 39:67 top.scala 213:33 top.scala 153:18]
    node _GEN_34 = mux(_T_18, data_mem.io_out, _GEN_33) @[Conditional.scala 39:67 top.scala 212:31]
    node _GEN_35 = mux(_T_17, reg_file.io_WriteData, _GEN_34) @[Conditional.scala 39:67 top.scala 211:32]
    node _GEN_36 = mux(_T_16, EX.io_aluOutput_out, _GEN_35) @[Conditional.scala 39:67 top.scala 210:32]
    node _GEN_37 = mux(_T_15, alu.io_out, _GEN_36) @[Conditional.scala 39:67 top.scala 209:33]
    node _GEN_38 = mux(_T_14, reg_file.io_rd2, _GEN_37) @[Conditional.scala 40:58 top.scala 208:32]
    node _ID_io_func3_T = bits(IF.io_ins_out, 14, 12) @[top.scala 224:31]
    node _ID_io_func7_T = bits(IF.io_ins_out, 30, 30) @[top.scala 225:31]
    node _ID_io_rs1Ins_in_T = bits(IF.io_ins_out, 19, 15) @[top.scala 234:35]
    node _ID_io_rs2Ins_in_T = bits(IF.io_ins_out, 24, 20) @[top.scala 235:35]
    node _ID_io_rd_in_T = bits(IF.io_ins_out, 11, 7) @[top.scala 236:31]
    node _T_20 = eq(HD.io_inst_forward, UInt<1>("h1")) @[top.scala 245:29]
    node _GEN_39 = mux(_T_20, HD.io_inst_out, inst_mem.io_inst) @[top.scala 245:41 top.scala 246:18 top.scala 249:22]
    node _GEN_40 = mux(_T_20, HD.io_current_pc_out, pc.io_pc_out) @[top.scala 245:41 top.scala 247:17 top.scala 54:16]
    node _T_21 = eq(HD.io_pc_forward, UInt<1>("h1")) @[top.scala 253:27]
    node _T_22 = eq(controler.io_next_pc, UInt<1>("h1")) @[top.scala 256:31]
    node _T_23 = eq(BL.io_output, UInt<1>("h1")) @[top.scala 257:25]
    node _T_24 = eq(controler.io_branch, UInt<1>("h1")) @[top.scala 257:56]
    node _T_25 = and(_T_23, _T_24) @[top.scala 257:33]
    node _pc_io_addr_T = asUInt(imm.io_sb_imm) @[top.scala 258:37]
    node _GEN_41 = mux(_T_25, _pc_io_addr_T, pc.io_pc_4) @[top.scala 257:65 top.scala 258:20 top.scala 263:20]
    node _GEN_42 = mux(_T_25, UInt<1>("h0"), _GEN_40) @[top.scala 257:65 top.scala 259:21]
    node _GEN_43 = mux(_T_25, UInt<1>("h0"), pc.io_pc_4) @[top.scala 257:65 top.scala 260:22 top.scala 55:17]
    node _GEN_44 = mux(_T_25, UInt<1>("h0"), _GEN_39) @[top.scala 257:65 top.scala 261:22]
    node _T_26 = eq(controler.io_next_pc, UInt<2>("h2")) @[top.scala 266:37]
    node _pc_io_addr_T_1 = asUInt(imm.io_uj_imm) @[top.scala 267:35]
    node _T_27 = eq(controler.io_next_pc, UInt<2>("h3")) @[top.scala 271:38]
    node _pc_io_addr_T_2 = asUInt(Jalr.io_out) @[top.scala 272:33]
    node _GEN_45 = mux(_T_27, _pc_io_addr_T_2, pc.io_pc_4) @[top.scala 271:51 top.scala 272:18 top.scala 278:18]
    node _GEN_46 = mux(_T_27, UInt<1>("h0"), _GEN_40) @[top.scala 271:51 top.scala 273:19]
    node _GEN_47 = mux(_T_27, UInt<1>("h0"), pc.io_pc_4) @[top.scala 271:51 top.scala 274:20 top.scala 55:17]
    node _GEN_48 = mux(_T_27, UInt<1>("h0"), _GEN_39) @[top.scala 271:51 top.scala 275:20]
    node _GEN_49 = mux(_T_26, _pc_io_addr_T_1, _GEN_45) @[top.scala 266:50 top.scala 267:18]
    node _GEN_50 = mux(_T_26, UInt<1>("h0"), _GEN_46) @[top.scala 266:50 top.scala 268:19]
    node _GEN_51 = mux(_T_26, UInt<1>("h0"), _GEN_47) @[top.scala 266:50 top.scala 269:20]
    node _GEN_52 = mux(_T_26, UInt<1>("h0"), _GEN_48) @[top.scala 266:50 top.scala 270:20]
    node _GEN_53 = mux(_T_22, _GEN_41, _GEN_49) @[top.scala 256:44]
    node _GEN_54 = mux(_T_22, _GEN_42, _GEN_50) @[top.scala 256:44]
    node _GEN_55 = mux(_T_22, _GEN_43, _GEN_51) @[top.scala 256:44]
    node _GEN_56 = mux(_T_22, _GEN_44, _GEN_52) @[top.scala 256:44]
    node _GEN_57 = mux(_T_21, HD.io_pc_out, _GEN_53) @[top.scala 253:39 top.scala 254:16]
    node _GEN_58 = mux(_T_21, _GEN_40, _GEN_54) @[top.scala 253:39]
    node _GEN_59 = mux(_T_21, pc.io_pc_4, _GEN_55) @[top.scala 253:39 top.scala 55:17]
    node _GEN_60 = mux(_T_21, _GEN_39, _GEN_56) @[top.scala 253:39]
    node _T_28 = eq(ID.io_operandAsel_out, UInt<2>("h2")) @[top.scala 298:31]
    node _alu_io_in1_T = asSInt(ID.io_pc4_out) @[top.scala 299:33]
    node _T_29 = eq(Forward_U.io_forward_a, UInt<1>("h0")) @[top.scala 301:33]
    node _T_30 = eq(Forward_U.io_forward_a, UInt<1>("h1")) @[top.scala 303:40]
    node _T_31 = eq(Forward_U.io_forward_a, UInt<2>("h2")) @[top.scala 305:40]
    node _GEN_61 = mux(_T_31, reg_file.io_WriteData, ID.io_operandA_out) @[top.scala 305:53 top.scala 306:16 top.scala 308:17]
    node _GEN_62 = mux(_T_30, EX.io_aluOutput_out, _GEN_61) @[top.scala 303:53 top.scala 304:17]
    node _GEN_63 = mux(_T_29, ID.io_operandA_out, _GEN_62) @[top.scala 301:46 top.scala 302:17]
    node _GEN_64 = mux(_T_28, _alu_io_in1_T, _GEN_63) @[top.scala 298:44 top.scala 299:16]
    node _T_32 = eq(ID.io_operandBsel_out, UInt<1>("h1")) @[top.scala 316:31]
    node _T_33 = eq(Forward_U.io_forward_b, UInt<1>("h1")) @[top.scala 318:34]
    node _T_34 = eq(Forward_U.io_forward_b, UInt<2>("h2")) @[top.scala 320:39]
    node _T_35 = eq(Forward_U.io_forward_b, UInt<1>("h0")) @[top.scala 322:39]
    node _GEN_65 = mux(_T_35, ID.io_operandB_out, ID.io_operandB_out) @[top.scala 322:52 top.scala 323:25 top.scala 325:21]
    node _GEN_66 = mux(_T_34, reg_file.io_WriteData, _GEN_65) @[top.scala 320:52 top.scala 321:25]
    node _GEN_67 = mux(_T_33, EX.io_aluOutput_out, _GEN_66) @[top.scala 318:46 top.scala 319:25]
    node _T_36 = eq(Forward_U.io_forward_b, UInt<1>("h0")) @[top.scala 327:33]
    node _T_37 = eq(Forward_U.io_forward_b, UInt<1>("h1")) @[top.scala 330:38]
    node _T_38 = eq(Forward_U.io_forward_b, UInt<2>("h2")) @[top.scala 333:37]
    node _GEN_68 = mux(_T_38, reg_file.io_WriteData, ID.io_operandB_out) @[top.scala 333:50 top.scala 334:16 top.scala 337:16]
    node _GEN_69 = mux(_T_37, EX.io_aluOutput_out, _GEN_68) @[top.scala 330:51 top.scala 331:16]
    node _GEN_70 = mux(_T_36, ID.io_operandB_out, _GEN_69) @[top.scala 327:46 top.scala 328:16]
    node _GEN_71 = mux(_T_32, ID.io_imm_out, _GEN_70) @[top.scala 316:38 top.scala 317:19]
    node _GEN_72 = mux(_T_32, _GEN_67, _GEN_70) @[top.scala 316:38]
    node _data_mem_io_Addr_T = asUInt(EX.io_aluOutput_out) @[top.scala 407:43]
    node _reg_file_io_WriteData_T = eq(Mem_wb.io_memToReg_out, UInt<1>("h0")) @[top.scala 431:33]
    node _reg_file_io_WriteData_T_1 = eq(Mem_wb.io_memToReg_out, UInt<1>("h1")) @[top.scala 432:33]
    node _reg_file_io_WriteData_T_2 = mux(_reg_file_io_WriteData_T_1, Mem_wb.io_dataOut_out, asSInt(UInt<1>("h0"))) @[Mux.scala 98:16]
    node _reg_file_io_WriteData_T_3 = mux(_reg_file_io_WriteData_T, Mem_wb.io_aluOutput_out, _reg_file_io_WriteData_T_2) @[Mux.scala 98:16]
    io_out <= UInt<1>("h0") @[top.scala 14:11]
    io_addr <= inst_mem.io_addr @[top.scala 346:12]
    pc.clock <= clock
    pc.reset <= reset
    pc.io_addr <= _GEN_57
    data_mem.clock <= clock
    data_mem.reset <= reset
    data_mem.io_Addr <= bits(_data_mem_io_Addr_T, 7, 0) @[top.scala 407:21]
    data_mem.io_Data <= EX.io_offSet_out @[top.scala 406:21]
    data_mem.io_MemWrite <= EX.io_memWrite_out @[top.scala 408:25]
    data_mem.io_MemRead <= EX.io_memRead_out @[top.scala 409:24]
    inst_mem.clock <= clock
    inst_mem.reset <= reset
    inst_mem.io_addr <= _inst_mem_io_addr_T @[top.scala 51:21]
    reg_file.clock <= clock
    reg_file.reset <= reset
    reg_file.io_write <= Mem_wb.io_regWrite_out @[top.scala 429:22]
    reg_file.io_rs1 <= _reg_file_io_rs1_T @[top.scala 60:20]
    reg_file.io_rs2 <= _reg_file_io_rs2_T @[top.scala 61:20]
    reg_file.io_rd <= Mem_wb.io_rd_out @[top.scala 435:19]
    reg_file.io_WriteData <= _reg_file_io_WriteData_T_3 @[top.scala 430:26]
    controler.clock <= clock
    controler.reset <= reset
    controler.io_opcod <= _controler_io_opcod_T @[top.scala 59:23]
    alu.clock <= clock
    alu.reset <= reset
    alu.io_alu_Op <= alu_cnt.io_x @[top.scala 342:17]
    alu.io_in1 <= _GEN_64
    alu.io_in2 <= _GEN_71
    imm.clock <= clock
    imm.reset <= reset
    imm.io_instr <= IF.io_ins_out @[top.scala 67:17]
    imm.io_pc_val <= IF.io_pc_out @[top.scala 68:18]
    Jalr.clock <= clock
    Jalr.reset <= reset
    Jalr.io_addr <= _GEN_32
    Jalr.io_pc_addr <= imm.io_i_imm @[top.scala 157:20]
    alu_cnt.clock <= clock
    alu_cnt.reset <= reset
    alu_cnt.io_alu_op <= ID.io_aluOp_out @[top.scala 78:22]
    alu_cnt.io_func3 <= ID.io_func3_o @[top.scala 79:21]
    alu_cnt.io_func7 <= bits(ID.io_func7_o, 0, 0) @[top.scala 80:21]
    IF.clock <= clock
    IF.reset <= reset
    IF.io_pc_in <= _GEN_58
    IF.io_pc4_in <= _GEN_59
    IF.io_ins_in <= _GEN_60
    ID.clock <= clock
    ID.reset <= reset
    ID.io_memWrite_in <= controler.io_memwrite @[top.scala 218:22]
    ID.io_memRead_in <= controler.io_memread @[top.scala 219:21]
    ID.io_memToReg_in <= controler.io_memtoreg @[top.scala 220:22]
    ID.io_operandAsel_in <= controler.io_op_a @[top.scala 226:25]
    ID.io_operandBsel_in <= controler.io_op_b @[top.scala 227:25]
    ID.io_br_en_in <= controler.io_branch @[top.scala 229:24]
    ID.io_aluOp_in <= controler.io_aluop @[top.scala 228:24]
    ID.io_regWrite_in <= controler.io_regwrite @[top.scala 221:22]
    ID.io_operandA_in <= reg_file.io_rd1 @[top.scala 222:22]
    ID.io_operandB_in <= reg_file.io_rd2 @[top.scala 223:22]
    ID.io_rd_in <= _ID_io_rd_in_T @[top.scala 236:16]
    ID.io_func3 <= _ID_io_func3_T @[top.scala 224:16]
    ID.io_func7 <= _ID_io_func7_T @[top.scala 225:16]
    ID.io_rs1Ins_in <= _ID_io_rs1Ins_in_T @[top.scala 234:20]
    ID.io_rs2Ins_in <= _ID_io_rs2Ins_in_T @[top.scala 235:20]
    ID.io_pc_in <= IF.io_pc_out @[top.scala 232:16]
    ID.io_pc4_in <= IF.io_pc4_out @[top.scala 233:17]
    ID.io_NextPc <= controler.io_next_pc @[top.scala 230:22]
    ID.io_imm <= _ID_io_imm_T_5 @[top.scala 129:14]
    EX.clock <= clock
    EX.reset <= reset
    EX.io_memWrite_in <= ID.io_memWrite_out @[top.scala 403:22]
    EX.io_memRead_in <= ID.io_memRead_out @[top.scala 404:21]
    EX.io_memToReg_in <= ID.io_memToReg_out @[top.scala 290:22]
    EX.io_rd_in <= ID.io_rd_out @[top.scala 287:16]
    EX.io_aluOutput_in <= alu.io_out @[top.scala 286:23]
    EX.io_regWrite_in <= ID.io_regWrite_out @[top.scala 291:27]
    EX.io_offSet_in <= _GEN_72
    Mem_wb.clock <= clock
    Mem_wb.reset <= reset
    Mem_wb.io_memToReg_in <= EX.io_memToReg_out @[top.scala 422:26]
    Mem_wb.io_rd_in <= EX.io_rd_out @[top.scala 427:20]
    Mem_wb.io_dataOut_in <= data_mem.io_out @[top.scala 425:25]
    Mem_wb.io_aluOutput_in <= EX.io_aluOutput_out @[top.scala 426:27]
    Mem_wb.io_regWrite_in <= EX.io_regWrite_out @[top.scala 423:26]
    Mem_wb.io_MemRead_in <= EX.io_memRead_out @[top.scala 421:25]
    Mem_wb.io_memWrite_in <= EX.io_memWrite_out @[top.scala 424:26]
    Forward_U.clock <= clock
    Forward_U.reset <= reset
    Forward_U.io_EX_MEM_REGRD <= EX.io_rd_out @[top.scala 40:30]
    Forward_U.io_MEM_WB_REGRD <= Mem_wb.io_rd_out @[top.scala 41:30]
    Forward_U.io_ID_EX_REGRS1 <= ID.io_rs1Ins_out @[top.scala 42:30]
    Forward_U.io_ID_EX_REGRS2 <= ID.io_rs2Ins_out @[top.scala 43:30]
    Forward_U.io_EX_MEM_REGWR <= EX.io_regWrite_out @[top.scala 44:30]
    Forward_U.io_MEM_WB_REGWR <= Mem_wb.io_regWrite_out @[top.scala 45:30]
    HD.clock <= clock
    HD.reset <= reset
    HD.io_IF_ID_INST <= IF.io_ins_out @[top.scala 239:22]
    HD.io_ID_EX_MEMREAD <= ID.io_memRead_out @[top.scala 240:25]
    HD.io_ID_EX_REGRD <= ID.io_rd_out @[top.scala 241:23]
    HD.io_pc_in <= IF.io_pc4_out @[top.scala 242:17]
    HD.io_current_pc <= IF.io_pc_out @[top.scala 243:22]
    BL.clock <= clock
    BL.reset <= reset
    BL.io_in_rs1 <= _GEN_31
    BL.io_in_rs2 <= _GEN_38
    BL.io_in_func3 <= _BL_io_in_func3_T @[top.scala 154:20]
    BF.clock <= clock
    BF.reset <= reset
    BF.io_ID_EX_REGRD <= ID.io_rd_out @[top.scala 141:23]
    BF.io_ID_EX_MEMRD <= ID.io_memRead_out @[top.scala 142:23]
    BF.io_EX_MEM_REGRD <= EX.io_rd_out @[top.scala 143:24]
    BF.io_EX_MEM_MEMRD <= EX.io_memRead_out @[top.scala 145:24]
    BF.io_MEM_WB_REGRD <= Mem_wb.io_rd_out @[top.scala 144:24]
    BF.io_MEM_WB_MEMRD <= Mem_wb.io_MemRead_out @[top.scala 146:24]
    BF.io_rs1_sel <= _BF_io_rs1_sel_T @[top.scala 147:19]
    BF.io_rs2_sel <= _BF_io_rs2_sel_T @[top.scala 148:19]
    BF.io_ctrl_branch <= controler.io_branch @[top.scala 149:23]
    SD.clock <= clock
    SD.reset <= reset
    SD.io_rs1_sel <= _SD_io_rs1_sel_T @[top.scala 86:19]
    SD.io_rs2_sel <= _SD_io_rs2_sel_T @[top.scala 87:19]
    SD.io_MEM_WB_regWr <= Mem_wb.io_regWrite_out @[top.scala 89:24]
    SD.io_MEM_WB_REGRD <= Mem_wb.io_rd_out @[top.scala 88:24]
