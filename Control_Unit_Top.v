`include "Alu_decoder.v"
`include "Main_decoder.v"

module Control_Untit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);

input [6:0] Op , funct7;
input [2:0] funct3;
output [1:0] ImmSrc;
output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
output [2:0] ALUControl;

wire [1:0] ALUOp;

main_decoder main_decoder (.op(Op),
                           .RegWrite(RegWrite),
                           .MemWrite(MemWrite),
                           .ResultSrc(ResultSrc),
                           .ALUSrc(ALUSrc),
                           .ImmSrc(ImmSrc),
                           .ALUOp(ALUOp),
                           .Branch(Branch));
ALU_Decoder ALU_Decoder(.ALUOp(ALUOp),
                        .funct3(funct3),
                        .funct7(funct7),
                        .op(Op),
                        .ALUControl(ALUControl));                           

endmodule