// Interface
interface mul_if (input logic clk, reset);
  logic [7:0] a, b;
  logic [15:0] out;
  logic en;
  logic ack;
  
  // Clocking block
  clocking cb @(posedge clk);
    default input #1 output #2;//manually written 
    //input signals is sampled #1 time unit before the clocking event
    //output signals are driven after #2 time units after the clocking event
    input out, ack;
    output a,b, en;
  endclocking
 
  //Modport
  modport TB (clocking cb, input clk, reset);
  modport RTL (input clk, reset, a,b, en, output out, ack);
  
endinterface

    
    
    //-------------------Testbench------------------
module tb_top;
  bit clk;
  bit reset;
  
  always #2 clk = ~clk;
  
  mul_if inf(clk, reset);
  multiplier DUT(inf.RTL);
  
  initial begin
    $monitor("time = %0t: a=%d b=%d, out=%d ack=%0d", $time, inf.a,inf.b,inf.out,inf.ack);
    clk = 0;
    reset = 1;
    @(posedge clk);
    reset = 0; 
    @(posedge clk);
    
    inf.TB.cb.a <= 'd5; inf.TB.cb.b <= 'd6;
    inf.TB.cb.en <= 1;
    @(posedge clk); 
    inf.TB.cb.en <= 0;
    
    @(posedge clk);
    inf.TB.cb.a <= 'd20; inf.TB.cb.b <= 'd7;
    inf.TB.cb.en <= 1;
    @(posedge clk);
    inf.TB.cb.en <= 0;
    
    @(posedge clk);
    $finish;
  end
endmodule

    // Design for Multiplier
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
    else 
      inf.ack <= 0;
  end
endmodule
