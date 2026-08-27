module alternate_0s_1s_tb;
  reg clk, rst, in;
  wire out;

  alternate_0s_1s dut (.clk(clk), .rst(rst), .in(in), .out(out));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("alternate.vcd");
    $dumpvars(0, alternate_0s_1s_tb);
    $monitor("Time=%0t | clk=%b | rst=%b | in=%b | out=%b", $time, clk, rst, in, out);
    rst = 1; 
    #15 rst = 0;

    #10 in = 0;
    #10 in = 1;
    #10 in = 0; 
    #10 in = 1;
    #10 in = 1;
    #10 in = 0; 
    #10 in = 1;

    #10 $finish;
  end
endmodule

