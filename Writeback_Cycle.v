//`include "Mux.v"

module writeback_cycle (clk, rst, ALUResultW, ResultSrcW, ReadDataW, PCPlus4W, ResultW);

// Declaration of I/Os

input clk, rst, ResultSrcW;
input [31:0] ReadDataW, PCPlus4W, ALUResultW;

output [31:0] ResultW;


// module instantiation 

Mux result_mux (.a(ALUResultW),
                .b(ReadDataW),
                .s(ResultSrcW),
                .c(ResultW));




endmodule