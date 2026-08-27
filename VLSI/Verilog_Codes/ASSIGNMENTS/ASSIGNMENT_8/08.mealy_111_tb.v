module mealy_111_tb;
  reg clk, rst;
  reg x;
  wire y;

  mealy_111 dut ( .clk(clk), .rst(rst), .x(x), .y(y) );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("mealy_111.vcd");
    $dumpvars(0, mealy_111_tb);
    $monitor("TIME = %0t | CLK  = %b | RST = %b | STATE = %b | NEXT STATE = %b | x = %b | y = %b", $time, clk, rst, dut.state, dut.next_state, x, y);
    rst = 1; x = 0;
    #20 rst = 0;
    x = 0; 
    #20

    #10 x = 1;   
    #10 x = 1;   
    #10 x = 1;   
    #10 x = 1;   
    #10 x = 0;   
    #10 x = 1;   
    #10 x = 1;   
    #10 x = 0;   
    #10 x = 1;   
    #10 x = 1;   
    #10 x = 1;   
    #10 $finish;
  end
endmodule

