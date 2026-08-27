module race_blocking;
  reg clk, a, b;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  always @(posedge clk) a = b;   // blocking
  always @(posedge clk) b = a;   // blocking

  initial begin
    a=0; b=1;
    $monitor("Time=%0t | clk=%b a=%b b=%b", $time, clk, a, b);
    #50 $finish;
  end
endmodule

