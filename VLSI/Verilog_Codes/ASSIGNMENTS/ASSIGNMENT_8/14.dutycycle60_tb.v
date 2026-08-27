module dutycycle_60_tb;
  reg clk;
  reg rst;
  wire clk_60percent;

  dutycycle_60 dut ( .clk(clk), .rst(rst), .clk_60percent(clk_60percent) );

  always #5 clk = ~clk;

  initial begin
    $monitor("Time=%0t | clk=%b | clk_60percent=%b | rst=%b", $time, clk, clk_60percent, rst);	  
    clk = 0;
    rst = 1;
    #10 rst = 0;
    #200 $finish;
  end
endmodule
