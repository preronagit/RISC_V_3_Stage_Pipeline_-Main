module Instruction_Memory(A,rst,RD);
input [31:0] A;
input rst;
output [31:0] RD;
//creation of memory

//reg [31:0] Mem; // a register of name mem having size of 32
reg [31:0] Mem [1023:0]; // memory having 1024 registers of 32 bit size each

assign RD =  (rst==1'b0)? 32'h00000000 : Mem[A[31:2]];  

initial begin
    $readmemh("memfile.hex",Mem);
end



endmodule