module mux4_casex (
  input [3:0] d,
  input [1:0] s,
  output reg y
);
  always @(*) begin
    casex (s)
      2'b0x: y = d[0];  // covers 00 or 01
      2'b1x: y = d[2];  // covers 10 or 11
      default: y = 1'bx;
    endcase
  end
endmodule

