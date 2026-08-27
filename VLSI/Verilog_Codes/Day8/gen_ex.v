module gen_ex(input clk, 
input [3:0] a,b, 
output reg [3:0] y);

genvar i;
generate
  for(i = 0; i<4; i=i+1) begin
     always @(posedge clk) begin
           y[i] = a[i]&b[i];
     end
   end
endgenerate
endmodule

module gen_ex_tb;
reg clk;
reg [3:0] a,b;
wire [3:0] y;

gen_ex uut(.clk(clk),  .a(a), .b(b), .y(y));

always #5 clk = ~clk;

initial begin
  $monitor("CLK = %b | A=%b | B=%b | Y=%b " ,clk,a,b,y);
  clk = 0;
  a=4'b1101; b=4'b1010;
  #10;
  a=4'b1011; b=4'b1111;
  #10;
  a=4'b0011; b=4'b1100;
  #10;
  $finish;
  end
endmodule
