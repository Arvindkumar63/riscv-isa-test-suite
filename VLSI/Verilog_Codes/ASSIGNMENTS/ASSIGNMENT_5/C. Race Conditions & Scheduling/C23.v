module race_blocking;
  reg clk, a, b;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  always @(posedge clk) a = b;   // blocking
  always @(posedge clk) b = a;   // blocking
  always @(posedge clk) begin
  $display("Time=%0t | clk=%b a=%b b=%b", $time, clk, a, b);
  end 
  initial begin
  #100;
  $finish;
  end
  initial begin
    a=0; b=1;
  end
endmodule
