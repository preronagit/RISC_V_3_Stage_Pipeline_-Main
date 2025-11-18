// `include "Control_Unit_Top.v"
// `include "Register_files.v"
// `include "Sign_Extend.v"
// `include "Mux.v"
// `include "ALU.v"
// `include "PC_Adder.v"
// `include "Data_Mem.v"

module execute_cycle(clk, rst, InstrD, PCD, PCPlus4D, ResultW, RDW, RegWriteW, ResultSrcW, ALUResultW, ReadDataW, PCPlus4W, PCSrcE, PCTargetE );

// Declaration of I/Os
input clk, rst;

input [31:0] InstrD, PCD , PCPlus4D, ResultW;

output [4:0] RDW;
output RegWriteW, ResultSrcW, PCSrcE;
output [31:0] ALUResultW, ReadDataW, PCPlus4W;
output [31:0] PCTargetE;
// Declaration of Interim wires 
wire [31:0] RD1_Ex, RD2_Ex, Imm_Ext_Ex, Src_B, ALUResult_Ex, ReadDataEx;
wire RegWriteEx, ALUSrcEx, MemWriteEx, ResultSrcEx, BranchEx, ZeroEx;
wire [1:0] ImmSrcEx;
wire [2:0] ALUControlEx;



// Interim Registers declaration
reg RegWriteEx_reg, ResultSrcEx_reg;
reg [31:0] ALU_Result_Ex_reg, ReadDataEx_reg, PCPlus4D_reg;
reg [4:0] RDEx_reg;
// module Instantiation
// control unit 
Control_Untit_Top control (.Op(InstrD[6:0]),
                           .RegWrite(RegWriteEx),
                           .ImmSrc(ImmSrcEx),
                           .ALUSrc(ALUSrcEx),
                           .MemWrite(MemWriteEx),
                           .ResultSrc(ResultSrcEx),
                           .Branch(BranchEx),
                           .funct3(InstrD[14:12]),
                           .funct7(InstrD[31:25]),
                           .ALUControl(ALUControlEx));

// Register file
Register_File rf (.A1(InstrD[19:15]),
                  .A2(InstrD[24:20]),
                  .A3(RDW),
                  .WD3(ResultW),
                  .WE3(RegWriteEx),
                  .clk(clk),
                  .rst(rst),
                  .RD1(RD1_Ex),
                  .RD2(RD2_Ex));

// sign extention 
Sign_Extend extension (.In(InstrD),
                       .Imm_Ext(Imm_Ext_Ex),
                       .ImmSrc(ImmSrcEx[0]));

// ALU Src Mux
Mux alu_src_mux (.a(RD2_Ex),
         .b(Imm_Ext_Ex),
         .s(ALUSrcEx),
         .c(Src_B));

// ALU unit
alu alu (.A(RD1_Ex),  
         .B( Src_B),
         .ALUControl(ALUControlEx),
         .Result(ALUResult_Ex),
         .Z(ZeroEx),
         .N(),
         .V(),
         .C());



//  Adder 
PC_Adder branch_adder (.a(PCD),
                    .b(Imm_Ext_Ex),
                    .c(PCTargetE),
                    .s());    
// Data memory
Data_Memory dmem (.A(ALUResult_Ex),
                  .WD3(RD2_Ex),
                  .clk(clk),
                  .rst(rst),
                  .WE(MemWriteEx),
                  .RD(ReadDataEx));


// Execute state register logic
always @ (posedge clk or negedge rst) begin
    if(rst == 1'b0) begin
         RegWriteEx_reg <= 1'b0;
         ResultSrcEx_reg <= 1'b0;
         ALU_Result_Ex_reg <= 32'h00000000;
          ReadDataEx_reg <= 32'h00000000; 
          PCPlus4D_reg <= 32'h00000000;
          RDEx_reg <= 5'b00000;
    end
    else begin
        RegWriteEx_reg <= RegWriteEx;
         ResultSrcEx_reg <= ResultSrcEx;
         ALU_Result_Ex_reg <= ALUResult_Ex;
          ReadDataEx_reg <= ReadDataEx; 
          PCPlus4D_reg <= PCPlus4D;
          RDEx_reg <= InstrD[11:7];
    end
end                  
// Output assignment                  
assign RDW = RDEx_reg;
assign RegWriteW = RegWriteEx_reg;
assign ResultSrcW = ResultSrcEx_reg;
assign ALUResultW = ALU_Result_Ex_reg;
assign ReadDataW = ReadDataEx_reg;
assign PCPlus4W = PCPlus4D_reg;
assign PCSrcE = (rst == 1'b0)? 1'b0 : (ZeroEx & BranchEx) ;    

endmodule