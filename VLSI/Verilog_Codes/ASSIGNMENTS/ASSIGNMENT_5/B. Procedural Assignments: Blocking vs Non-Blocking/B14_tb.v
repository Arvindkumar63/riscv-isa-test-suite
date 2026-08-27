module pipeline_reg_tb;
  reg clk;
  reg [7:0]din;
  wire [7:0]q1,q2;

  pipeline_reg uut (.clk(clk),.din(din),.q1(q1),.q2(q2));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;   
  end

  initial begin
    $monitor("Time=%0t | clk=%b | din=%b | q1=%b | q2=%b",$time,clk,din,q1,q2);

    din = 8'b00000000;
    #10 din = 8'b11011011;  
    #10 din = 8'b10110011;  
    #10 din = 8'b11001111;  
    #10 din = 8'b00110000;  
    #20 $finish;
  end
endmodule

