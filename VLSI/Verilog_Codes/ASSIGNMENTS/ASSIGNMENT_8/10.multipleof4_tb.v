module multiple_of_4_tb;
  reg clk, rst, in;
  wire out;

  multiple_of_4 dut ( .clk(clk), .rst(rst), .in(in), .out(out) );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns period
  end

  initial begin
    $dumpfile("multiple_of_4.vcd");
    $dumpvars(0, multiple_of_4_tb);
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
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #20 $finish;
  end
endmodule

