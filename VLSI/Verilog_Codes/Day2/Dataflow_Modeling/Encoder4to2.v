module Encoder4to2(
  input  [3:0]d,
  output [1:0]y);

  assign y = (d[3]) ? 2'b11 :
             (d[2]) ? 2'b10 :
             (d[1]) ? 2'b01 : 2'b00;    //msb priority

endmodule

