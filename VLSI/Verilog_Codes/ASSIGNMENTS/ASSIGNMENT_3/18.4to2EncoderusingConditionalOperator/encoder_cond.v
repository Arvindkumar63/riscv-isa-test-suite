// 4-to-2 encoder (no priority, assumes one input is active at a time)
module encoder_cond(
  input [3:0]d,
  output [1:0]y);

  assign y = d[0] ? 2'b00 :
             d[1] ? 2'b01 :
             d[2] ? 2'b10 :
             d[3] ? 2'b11 : 2'bxx;  // undefined if no input active

endmodule

