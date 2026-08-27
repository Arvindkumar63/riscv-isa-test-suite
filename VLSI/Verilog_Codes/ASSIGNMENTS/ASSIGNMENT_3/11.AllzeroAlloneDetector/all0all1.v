module all0all1(
  input [7:0]data,
  output zero,one);

  assign zero = ~(|data);
  assign one = &data;

endmodule
