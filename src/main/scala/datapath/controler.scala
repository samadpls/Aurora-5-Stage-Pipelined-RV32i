package controler
import chisel3._
import chisel3.util._
class control extends Bundle {
    val opcod = Input ( UInt ( 7.W ) )
    val memwrite=Output(Bool())
    val branch=Output(Bool())
    val memread =Output(Bool())
    val regwrite=Output(Bool())
    val memtoreg=Output(Bool())
    val aluop=Output(UInt(3.W))
    val op_a=Output(UInt(2.W))
    val op_b=Output(Bool())
    val extend_sel=Output(UInt(2.W)) 
    val next_pc=Output(UInt(2.W))
   
   
   
}
class controler extends Module {
        val io = IO (new control())
        io.memwrite:=0.B
        io.branch:=0.B
        io.memread :=0.B
        io.regwrite:=0.B
        io.memtoreg:=0.B
        io.aluop:="b000".U
        io.op_a:="b00".U
        io.op_b:=0.B
        io.extend_sel:=0.U
        io.next_pc:="b00".U
    switch (io.opcod){
        is("b0010011".U){ //I-type 
        io.regwrite:=1.B
        io.aluop:="b001".U
        io.op_b:=1.B
        io.memwrite:=0.B
        io.branch:=0.B
        io.memread :=0.B
        io.memtoreg:=0.B
        io.op_a:="b00".U
        io.extend_sel:=0.U
        io.next_pc:="b00".U
        }
        is("b0000011".U){ // I-type (load) b0000011
            io.regwrite:=1.B
            io.memread:=1.B
            io.memtoreg:=1.B
            io.aluop:="b100".U 
            io.op_b:=1.B
            io.memwrite:=0.B
            io.branch:=0.B
            io.op_a:="b00".U
            io.extend_sel:=0.U
            io.next_pc:="b00".U
        }
         is("b1101111".U){ // Jal b1101111
            io.regwrite:=1.B
            io.aluop:="b011".U
            io.op_a:="b01".U
            io.next_pc:="b10".U
            io.memwrite:=0.B
            io.branch:=0.B
            io.memread :=0.B
            io.memtoreg:=0.B
            io.op_b:=0.B
            io.extend_sel:=0.U
        }

           is("b1100111".U){ // Jal-R b1100111
            io.regwrite:=1.B
            io.aluop:="b011".U
            io.op_a:="b01".U
            io.op_b:=1.B
            io.next_pc:="b11".U
            io.memwrite:=0.B
            io.branch:=0.B
            io.memread :=0.B
            io.memtoreg:=0.B
            io.extend_sel:=0.U
        } 

        is("b0110011".U){ //R-type b0110011
            io.regwrite:=1.B
            io.memwrite:=0.B
            io.branch:=0.B
            io.memread :=0.B
            io.memtoreg:=0.B
            io.aluop:="b000".U
            io.op_a:="b00".U
            io.op_b:=0.B
            io.extend_sel:=0.U
            io.next_pc:="b00".U
          }
        is("b0100011".U){ //S-type b0100011
            io.memwrite:=1.B
            io.regwrite:=1.B
            io.aluop:="b101".U
            io.op_b:=1.B
            io.extend_sel:="b01".U
            io.memwrite:=0.B
            io.branch:=0.B
            io.memread :=0.B
            io.memtoreg:=0.B
            io.op_a:="b00".U
            io.next_pc:="b00".U
        }
       
        is("b1100011".U){ //SB-type b1100011
            io.branch:=1.B
            io.aluop:="b010".U
            io.next_pc:="b01".U
            io.memwrite:=0.B
            io.memread :=0.B
            io.regwrite:=0.B
            io.memtoreg:=0.B
            io.op_a:="b00".U
            io.op_b:=0.B
            io.extend_sel:=0.U

        }
        is("b0110111".U){ //U-type b0010111
            io.regwrite:=1.B
            io.aluop:="b110".U
            io.op_a:="b10".U
            io.op_b:=1.B
            io.next_pc:="b00".U
            io.extend_sel:="b10".U 
            io.memwrite:=0.B
            io.branch:=0.B
            io.memread :=0.B
            io.memtoreg:=0.B
        }
        
    }
        
}
