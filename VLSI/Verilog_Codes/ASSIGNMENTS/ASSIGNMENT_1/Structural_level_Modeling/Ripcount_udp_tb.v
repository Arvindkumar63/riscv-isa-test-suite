module Ripcount_udp_tb;
  reg clk,rst;
  wire [3:0]q;

  Ripcount_udp uut(clk,rst,q);

  initial begin
    $dumpfile("Ripcount_udp.vcd");
    $dumpvars(0, Ripcount_udp_tb);
    $monitor("TIME = %t , Q = %b" ,$time,q);
    
    clk=0; rst=1; #5; rst=0;
    #200 $finish;
  end

  always #5 clk = ~clk;

endmodule

