module Data_Memory (A,WD3,clk,rst,WE,RD);

input [31:0] A,WD3;
input clk,rst,WE;
output [31:0] RD;

reg [31:0] Data_MEM [1023:0];

//read
assign RD= (WE==1'b0) ? Data_MEM[A]: 32'h00000000;
    
//write
always @(posedge clk) begin
    
    if(WE) begin  
        Data_MEM[A]<=WD3;
    end
end
initial begin
    // Data_MEM [28] = 32'h00000020;
    // Data_MEM [40] = 32'h00000002;
    Data_MEM[0] = 32'h00000000;
end
endmodule 