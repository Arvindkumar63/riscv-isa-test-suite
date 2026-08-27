module counter_tb;
  reg rst,clk;
  wire [3:0]count;

  counter uut(.rst(rst), .clk(clk), .count(count));

  initial begin
   $dumpfile("counter.vcd");
   $dumpvars;
   $monitor("TIME = %0t clk=%b rst=%b count=%b",$time,clk,rst,count);
       
   clk=0;
   rst=1;#10;
   rst=0;
   #150;
   $finish;
  end
  always #5 clk = ~clk;
endmodule
