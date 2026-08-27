module add2comp(
  input [3:0] x,y,
  input c_in,
  output [3:0] sum, 
  output c_out );

  wire [3:0] t;
  assign t = y^{4{c_in}};
  assign {c_out,sum} = x+t+c_in;

endmodule
