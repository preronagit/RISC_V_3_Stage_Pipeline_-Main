
// `include "Mux.v"
// `include "PC.v"
// `include "Instruction_Memory.v"
// `include "PC_Adder.v"
module fetch_cycle (clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D);

input clk, rst, PCSrcE;
input [31:0] PCTargetE;
output [31:0] InstrD, PCD, PCPlus4D;

//interim wire
wire [31:0] PC_F,PCF,PCPlus4F;
wire [31:0] InstrF;

//Declaration of Registers
reg [31:0] InstrF_reg;
reg [31:0] PCF_reg;
reg [31:0] PCPlus4F_reg;

//Instantiation of modules
// Declaration of PC Mux
Mux PC_MUX (.a(PCPlus4F),
            .b(PCTargetE),
            .s(PCSrcE),
            .c(PC_F));

// Declaration of PC Counter
PC_Module Program_Counter (.PC_NEXT(PC_F),
                            .PC(PCF),
                            .rst(rst),
                            .clk(clk));

// Declaration of Instruction memory
Instruction_Memory IMEM (.A(PCF),
                        .rst(rst),
                        .RD(InstrF));

// Declaration of PC Adder

PC_Adder PC_adder (.a(PCF),
                  .b(32'h00000004),
                  .c(PCPlus4F),
                  .s()
                  );

//Fetch Cycle Register Logic
always @(posedge clk or negedge rst) begin
    if(rst==1'b0) begin
        InstrF_reg <= 32'h00000000;
        PCF_reg <= 32'h00000000;
        PCPlus4F_reg <= 32'h00000000;
    end
    else begin
        InstrF_reg <= InstrF;
        PCF_reg <= PCF;
        PCPlus4F_reg <= PCPlus4F;
    end
end

// Assigning Registers values to the output port 
assign InstrD = (rst==1'b0) ? 32'h00000000 : InstrF_reg;
assign PCD = (rst==1'b0) ? 32'h00000000 : PCF_reg;
assign PCPlus4D = (rst==1'b0) ? 32'h00000000 : PCPlus4F_reg;

endmodule