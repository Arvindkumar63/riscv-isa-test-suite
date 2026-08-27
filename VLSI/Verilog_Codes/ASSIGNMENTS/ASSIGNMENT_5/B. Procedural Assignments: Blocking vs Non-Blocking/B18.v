module mix;
  reg a,b,clk;

always @(posedge clk) begin
  a <= b;
  b = a;
end

initial begin
  clk=0;
  forever #5 clk = ~clk;
  end

initial begin
  $monitor("clk = %b a = %b  b = %b ",clk,a,b);
  a=0; b=1; #50;
  $finish;
  end

endmodule
