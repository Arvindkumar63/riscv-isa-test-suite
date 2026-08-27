module paritygen(
  input [8:0]data,
  output ep,op);
  assign ep = ^data;
  assign op = ~ep;
endmodule
