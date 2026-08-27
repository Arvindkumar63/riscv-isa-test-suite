module comparator(
  input [3:0]a,b,
  output eq,lt,gt);

  assign eq = (a==b);
  assign lt = (a<b);
  assign gt = (a>b);

endmodule
