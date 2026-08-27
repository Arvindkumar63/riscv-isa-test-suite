module sync_up_counter_tb;
  reg clk, reset;
  wire [3:0] q;

  sync_up_counter uut (.clk(clk), .reset(reset), .q(q));

  initial begin 
    clk = 0; 
    forever #5 clk = ~clk; 
  end

  initial begin
    $dumpfile("sync_up.vcd");
    $dumpvars(0, sync_up_counter_tb);
    $monitor("TIME=%0t | clk=%b | reset=%b | Q=%d " , $time,clk,reset,q);
    reset=1; #10;
   reset=0; #250;
    $finish;
  end
endmodule

