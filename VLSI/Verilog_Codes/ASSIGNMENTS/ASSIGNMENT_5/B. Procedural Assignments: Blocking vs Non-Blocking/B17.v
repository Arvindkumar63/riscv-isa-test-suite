module race;
 reg clk, a,b,c,d;

//wrong (race-prone)
always @(posedge clk) a = b;
always @(posedge clk) b = a;

// Correct (race-free)
always @(posedge clk) begin
  c <= d;
  d <= c;
end

initial begin 
  clk=0;
  forever #5 clk = ~clk;
  end 

initial begin 
  $monitor("%0t | clk=%b a=%b b=%b c=%b d=%b",$time,clk,a,b,c,d);
  a=1; b=0; c=0; d=1;
  #50;
  $finish;
end 

endmodule

