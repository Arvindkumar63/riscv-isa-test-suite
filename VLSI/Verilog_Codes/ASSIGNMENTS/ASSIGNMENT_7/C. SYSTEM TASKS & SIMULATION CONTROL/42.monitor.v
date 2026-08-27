module monitor;
  reg clk, data;

  initial begin
    clk = 0; data = 0;
    $monitor("TIME=%0t | clk=%b | data=%b",$time, clk, data);
  end

  always #5 clk = ~clk;   

  initial begin
    #7 data = 1;
    #10 data = 0;
    #12 data = 1;
    #20 $finish;
  end
endmodule

