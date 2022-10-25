package controler
import chisel3._
import chisel3.util._

class ALUIO4 extends Bundle {
    val alu_Op = Input( UInt ( 5.W ) )
    val in1=Input(SInt(32.W))
    val in2=Input(SInt(32.W))
    val out=Output(SInt(32.W))
    
}

class ALU4 extends Module{
    val io = IO (new ALUIO4())
    io.out:=0.S
    switch(io.alu_Op){
        is("b00000".U){ io.out:=io.in1+io.in2}//add addi
        is("b00001".U){io.out:=io.in1<<io.in2(4,0) } //sll
        is("b00010".U){  
            when(io.in1<io.in2) 
            {io.out:=1.S}.otherwise{
                io.out:=0.S}} //slt
        is("b00011".U ){
            when(io.in1.asUInt<io.in2.asUInt){io.out:=1.S}.otherwise{io.out:=0.S}
        }           // SLTU/SLTUI/BLTU
        is("b10110".U){
            when(io.in1.asUInt<io.in2.asUInt){io.out:=1.S}.otherwise{io.out:=0.S}
        }     
        is("b00100".U){io.out:=io.in1 ^ io.in2} //xor
        is("b00101".U){io.out:=(io.in1.asUInt>>io.in2(4,0).asUInt).asSInt} //srl
        is("b00110".U){io.out:=io.in1| io.in2} //or
        is("b00111".U){io.out:=io.in1 & io.in2} //and
        is("b01000".U){io.out:=io.in1 - io.in2} //sub
        is("b01101".U){io.out:=(io.in1.asUInt>>io.in2(4,0).asUInt).asSInt} //sra
        is("b11111".U){io.out:= io.in1} //jal jarlr


    }


}





