// Design a Multiplier using modports
module multiplier(mul_if.RTL inf);
  always@(posedge inf.clk or posedge inf.reset) begin 
    if(inf.reset) begin 
      inf.out <= 0;
      inf.ack <= 0;
    end
    else if(inf.en) begin
      inf.out <= inf.a * inf.b;
      inf.ack <= 1;
    end
    else inf.ack <= 0;
  end
endmodule

// Interface
interface mul_if (input logic clk, reset);
  logic [7:0] a, b;
  logic [15:0] out;
  logic en;
  logic ack;
  
  modport TB (output a,b, en, input out, ack);
  modport RTL (input clk, reset, a,b, en, output out, ack);
endinterface

//Top module
module tb_top;
  bit clk;
  bit reset;
  
  mul_if inf(clk, reset);
  multiplier DUT(inf.RTL);
  
  always #2 clk = ~clk;
  
  initial begin
    $monitor("time = %0t: a=%d b=%d, out=%d ack=%0d", $time, inf.TB.a,inf.TB.b,inf.TB.out,inf.TB.ack);
    clk = 0;
    reset = 1;
    #2;
    reset = 0;
    #4;
    
    inf.TB.a = 'd5; inf.TB.b = 'd6;
    inf.TB.en = 1;
    #4 inf.TB.en = 0;
    
    #4;
    inf.TB.a = 'd20; inf.TB.b = 'd7;
    inf.TB.en = 1;
    #4 inf.TB.en = 0;
    
    #10;
    $finish;
  end
endmodule
