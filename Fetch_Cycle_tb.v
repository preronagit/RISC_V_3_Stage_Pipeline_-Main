module fetch_cycle_tb ();

// Declaration I/O
reg clk =1 , rst , PCSrcE;
reg [31:0] PCTargetE;
wire [31:0] InstrD, PCD, PCPlus4D;

// dut instantiation 

fetch_cycle dut (.clk(clk),
                 .rst(rst),
                 .PCSrcE(PCSrcE),
                 .PCTargetE(PCTargetE),
                 .InstrD(InstrD),
                 .PCD(PCD),
                 .PCPlus4D(PCPlus4D));

// clock generation
always begin
    clk = ~clk;
    #50;
end

// Providing stimulus

initial begin
    rst <=1'b0;
    #200;
    rst<= 1'b1;
    PCSrcE <= 1'b0;
    PCTargetE <= 32'h00000000;
    #500;
    $finish;
end
 
// Waveform generation

initial begin
    $dumpfile("fetch.vcd");
    $dumpvars(0);
end

endmodule