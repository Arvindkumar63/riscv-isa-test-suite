module clock;
  reg clk;

initial begin
  #5 clk = 0;
  forever #5 clk = ~clk;
end

initial begin
   $monitor ("TIME=%0t clk=%b",$time,clk);
   #100
   $finish;
end
endmodule

