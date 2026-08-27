module same_var;
  reg a,clk;

always @(posedge clk) a = 0;
always @(posedge clk) a = 1;


initial begin
  clk=0;
  forever #5 clk = ~clk;
  end

initial begin
  $monitor("clk = %b a = %b ",clk,a);
  #50;
  $finish;
  end

endmodule
