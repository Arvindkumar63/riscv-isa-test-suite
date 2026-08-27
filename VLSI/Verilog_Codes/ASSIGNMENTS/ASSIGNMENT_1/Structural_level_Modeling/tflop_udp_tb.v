module tflop_udp_tb;
  reg clk,t,rst;
  wire q;
 
  tflop_udp uut(q,clk,t,rst);
  
  //clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // toggles every 5 ns
  end

  initial begin
    $dumpfile("tflop_udp.vcd");
    $dumpvars(0,tflop_udp_tb);
    $display("Time | CLK T RST| Q");
    $display("-----------------");
    $monitor("%4t | %b  %b   %b | %b", $time,clk,t,rst,q);

    rst=1; t=0; #10;
    rst=0; t=0; #10;
    t=0; #10;
    t=1; #10;
    t=1; #10;
    t=0; #10;
    t=0; #10;
    t=1; #10;
    t=0; #10;
    t=1; #10;
   
 
    $finish;
  end

endmodule
