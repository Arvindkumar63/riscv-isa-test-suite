module siso3bit_tb;
  reg clk,rst,din;
  wire q_out;

  siso3bit uut(.clk(clk), .rst(rst), .din(din), .q_out(q_out));

  initial begin 
    $dumpfile("siso.vcd");
    $dumpvars;
    $monitor (" TIME=%0t clk=%b rst=%b din=%b q_out=%b",$time,clk,rst,din,q_out);

    clk=0;
    rst=0; din=0; #5;
    rst=0;
    din=0; #10;
    din=1; #10;
    din=1; #10;
    din=0; #10;
    din=0; #10;
    $finish;
   end
   always #5 clk=~clk;
endmodule 
