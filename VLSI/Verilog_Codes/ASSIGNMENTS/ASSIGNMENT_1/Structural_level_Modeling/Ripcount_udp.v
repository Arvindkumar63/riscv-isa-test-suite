module Ripcount_udp(
  input clk,rst, 
  output [3:0]q);

  tflop_udp tff0(q[0],clk,1'b1,rst);
  tflop_udp tff1(q[1],q[0],1'b1,rst);
  tflop_udp tff2(q[2],q[1],1'b1,rst);
  tflop_udp tff3(q[3],q[2],1'b1,rst);

endmodule

