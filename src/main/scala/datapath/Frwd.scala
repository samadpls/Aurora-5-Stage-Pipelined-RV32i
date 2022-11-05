package  datapath
import chisel3._ 
import chisel3.util._

class ForwardUnit extends Module {
    val io = IO(new Bundle {
        val EX_MEM_REGRD = Input(UInt(5.W))
        val MEM_WB_REGRD = Input(UInt(5.W))
        val ID_EX_REGRS1 = Input(UInt(5.W))
        val ID_EX_REGRS2 = Input(UInt(5.W))
        val EX_MEM_REGWR = Input(UInt(1.W))
        val MEM_WB_REGWR = Input(UInt(1.W))
        val forward_a = Output(UInt(2.W))
        val forward_b = Output(UInt(2.W))
    })

    io.forward_a := "b00".U
    io.forward_b := "b00".U

    when(io.EX_MEM_REGWR === "b1".U && io.EX_MEM_REGRD =/= "b00000".U && (io.EX_MEM_REGRD === io.ID_EX_REGRS1) && (io.EX_MEM_REGRD === io.ID_EX_REGRS2)) {
        io.forward_a := "b01".U
		io.forward_b := "b01".U
    }.elsewhen(io.EX_MEM_REGWR === "b1".U && io.EX_MEM_REGRD =/= "b00000".U && (io.EX_MEM_REGRD === io.ID_EX_REGRS2)) { 
		io.forward_b := "b01".U   
    }.elsewhen(io.EX_MEM_REGWR === "b1".U && io.EX_MEM_REGRD =/= "b00000".U && (io.EX_MEM_REGRD === io.ID_EX_REGRS1)) {    
		io.forward_a := "b01".U     
    }
    when(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U && (io.MEM_WB_REGRD === io.ID_EX_REGRS1) && (io.MEM_WB_REGRD === io.ID_EX_REGRS2)) {
        io.forward_a := "b10".U
        io.forward_b := "b10".U
    }.elsewhen(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U && 	(io.MEM_WB_REGRD === io.ID_EX_REGRS2)) {
    	io.forward_b := "b10".U  
    }.elsewhen(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U &&(io.MEM_WB_REGRD === io.ID_EX_REGRS1)) {       
	io.forward_a := "b10".U
    }
    // EX HAZARD
    when(io.EX_MEM_REGWR === "b1".U && io.EX_MEM_REGRD =/= "b00000".U && (io.EX_MEM_REGRD=== io.ID_EX_REGRS1) && (io.EX_MEM_REGRD === io.ID_EX_REGRS2)) {
        io.forward_a := "b01".U
		io.forward_b := "b01".U
    
    } .elsewhen(io.EX_MEM_REGWR === "b1".U && io.EX_MEM_REGRD =/= "b00000".U && (io.EX_MEM_REGRD === io.ID_EX_REGRS2)) {
        io.forward_b := "b01".U
    
    } .elsewhen(io.EX_MEM_REGWR === "b1".U && io.EX_MEM_REGRD =/= "b00000".U &&(io.EX_MEM_REGRD === io.ID_EX_REGRS1)) {  
		io.forward_a := "b01".U
    
    }
    // MEM HAZARD
    when(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U && (io.MEM_WB_REGRD === io.ID_EX_REGRS1) && (io.MEM_WB_REGRD === io.ID_EX_REGRS2)) {
    		io.forward_a := "b10".U
    		io.forward_b := "b10".U

	}.elsewhen(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U && (io.MEM_WB_REGRD === io.ID_EX_REGRS2)) {
    		io.forward_b := "b10".U

	}.elsewhen(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U &&(io.MEM_WB_REGRD === io.ID_EX_REGRS1)) { 
		io.forward_a := "b10".U

	}
    when(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U && ~((io.EX_MEM_REGWR === "b1".U) && (io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.ID_EX_REGRS1) && (io.EX_MEM_REGRD === io.ID_EX_REGRS2)) && (io.MEM_WB_REGRD === io.ID_EX_REGRS1) && (io.MEM_WB_REGRD === io.ID_EX_REGRS2)) {
    	io.forward_a := "b10".U
    	io.forward_b := "b10".U
    }.elsewhen(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U && ~((io.EX_MEM_REGWR === "b1".U) && (io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.ID_EX_REGRS2)) && (io.MEM_WB_REGRD === io.ID_EX_REGRS2)) {    
	io.forward_b := "b10".U 
    }.elsewhen(io.MEM_WB_REGWR === "b1".U && io.MEM_WB_REGRD =/= "b00000".U && ~((io.EX_MEM_REGWR === "b1".U) && (io.EX_MEM_REGRD =/= "b00000".U) && (io.EX_MEM_REGRD === io.ID_EX_REGRS2))  && (io.MEM_WB_REGRD === io.ID_EX_REGRS1)) {
    io.forward_a := "b10".U
    }
    


}