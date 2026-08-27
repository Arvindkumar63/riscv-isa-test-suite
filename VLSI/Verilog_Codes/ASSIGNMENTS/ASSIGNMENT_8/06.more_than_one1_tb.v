module more_than_one1_tb;
  reg clk,rst,in;
  wire out;
  
  more_than_one1 uut(.clk(clk), .rst(rst), .in(in), .out(out));

  initial clk = 0;   
  always #5 clk = ~clk;
    
  initial begin
    $dumpfile("more_than_one1.vcd");
    $dumpvars;
    $monitor ("TIME = %0t | CLK = %b | RST = %b | STATE = %b | NEXT_STATE = %b | IN = %b | OUT = %b " , $time,clk,rst,uut.state,uut.next_state,in,out);
    #5 rst = 1;
    #5 rst = 0;
    #10 in = 0;
    #10 in = 0;   
    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10;
    $finish;
  end
endmodule
