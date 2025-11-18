`include "Fetch_Cycle.v"
`include "Execute_Cycle.v"
`include "Writeback_Cycle.v"
`include "PC.v"
`include "PC_Adder.v"
`include "Instruction_Memory.v"
`include "Control_Unit_Top.v"
`include "Register_files.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Data_Mem.v"
`include "Mux.v"

module Pipeline_top (clk,rst);

input clk, rst;

// Declaration of Interim Wires
wire PCSrcE, RegWriteW, ResultSrcW;
wire [4:0]  RDW;
wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW;
wire [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
// Module Initiation
// Fetch cycle 
fetch_cycle Fetch (
                        .clk(clk), 
                        .rst(rst), 
                        .PCSrcE(PCSrcE), 
                        .PCTargetE(PCTargetE), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D)
                    );

// Decode+ Execute + Mem 
execute_cycle execute (.clk(clk),
                       .rst(rst),
                       .InstrD(InstrD),
                       .PCD(PCD),
                       .PCPlus4D(PCPlus4D),
                       .ResultW(ResultW),
                       .RDW(RDW),
                       .RegWriteW(RegWriteW),
                       .ResultSrcW(ResultSrcW),
                       .ALUResultW(ALU_ResultW),
                       .ReadDataW(ReadDataW),
                       .PCPlus4W(PCPlus4W),
                       .PCSrcE(PCSrcE),
                       .PCTargetE(PCTargetE) );                                        

 
// Write Back Stage
writeback_cycle WriteBack (
                        .clk(clk), 
                        .rst(rst), 
                        .ResultSrcW(ResultSrcW), 
                        .PCPlus4W(PCPlus4W), 
                        .ALUResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW), 
                        .ResultW(ResultW)
                    );                                            
endmodule 