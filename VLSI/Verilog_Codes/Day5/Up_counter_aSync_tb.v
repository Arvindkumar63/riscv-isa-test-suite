module async_up_counter_tb;

  reg clk;
  reg reset;
  wire [3:0] q;

  async_up_counter uut (.clk(clk),.reset(reset),.q(q));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;  
  end

  initial begin
    $dumpfile("async_up_counter.vcd");
    $dumpvars(0, async_up_counter_tb);
    $monitor("Time=%0t | reset=%b | q=%b", $time, reset, q);
    reset = 1;  
    #10 reset = 0;

    #100 reset = 1; 
    #10 reset = 0;

    #150 $finish;
  end
endmodule

