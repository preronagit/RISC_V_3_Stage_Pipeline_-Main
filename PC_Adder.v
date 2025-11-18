module PC_Adder (a,b,c,s);
input [31:0] a,b;
input s;
output [31:0] c;

assign c = a+b;
    
endmodule