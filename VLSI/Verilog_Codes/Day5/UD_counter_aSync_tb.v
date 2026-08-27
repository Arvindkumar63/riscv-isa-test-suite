module async_updown_counter_tb;
  reg clk,reset,up;
  wire [3:0] q;

  async_updown_counter uut (.clk(clk), .reset(reset), .up(up), .q(q));

  initial begin
   clk=0;
   forever #5 clk=~clk;
  end

  initial begin
    $dumpfile("async_updown_counter.vcd");
    $dumpvars(0,async_updown_counter_tb);
    $monitor("TIME=%0t | clk=%b | reset=%b | up=%b | q=%b ",$time,clk,reset,up,q);

    #5; reset=1;
    #10; reset=0; up=1;
    #100; up=0;
    #200; $finish;
  end
endmodule
