module nand_array(
  input [3:0] a,b,
  output [3:0] y);

  nand g[3:0](y, a, b);  // array of 4 NAND gates

endmodule


