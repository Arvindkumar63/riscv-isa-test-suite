module dff_blocking_tb;
  reg clk,d;
  wire q;

  dff_blocking uut(clk, d, q);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    d=0; #7 d=1; #10 d=0; #10 d=1;
    #50 $finish;
  end

  initial 
  $monitor("Time=%0t | clk=%b d=%b q=%b", $time, clk, d, q);
endmodule
