module Register_File (A1,A2,A3,WD3,WE3,clk,rst,RD1,RD2);

input [4:0] A1,A2,A3;
input [31:0] WD3;
input clk,rst,WE3;
output [31:0] RD1,RD2;

//creatioon of memory
reg[31:0] Registers[31:0];

// Read functionality
assign RD1 = (!rst)? 32'h00000000 : Registers[A1];
assign RD2 = (!rst)? 32'h00000000 : Registers[A2];

//write functionality 

always @(posedge clk) begin
    if(WE3) begin
        Registers[A3] <= WD3;
    end

end
initial begin
    // Registers [9] = 32'h00000020;
    // Registers [6] = 32'h0000000A;
    // Registers [5] = 32'h00000006;
    // Registers [11] = 32'h00000028;
    // Registers [12] = 32'h00000030;
    //Registers[5] = 32'h00000005;
    //Registers[6] = 32'h00000004;
    Registers[0] = 32'b00000000;
end
endmodule