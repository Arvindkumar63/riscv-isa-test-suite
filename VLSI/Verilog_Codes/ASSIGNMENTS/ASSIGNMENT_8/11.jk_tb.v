module jk_tb;
  reg clk, rst, j, k;
  wire out;

  jk dut ( .clk(clk), .rst(rst), .j(j), .k(k), .out(out) );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  initial begin
    $dumpfile("jk.vcd"); 
    $dumpvars(0, jk_tb);
    $monitor("Time=%0t | j=%b k=%b | out=%b", $time, j, k, out);
    rst = 1; j = 0; k = 0;
    #15 rst = 0; 

    #10 j = 1; k = 0; 
    #10 j = 0; k = 0; 
    #10 j = 0; k = 1; 
    #10 j = 1; k = 0; 
    #10 j = 0; k = 1; 
    #10 j = 1; k = 0; 
    #10 j = 1; k = 1; 
    #10 j = 0; k = 1; 

    #20 $finish;
  end
endmodule
