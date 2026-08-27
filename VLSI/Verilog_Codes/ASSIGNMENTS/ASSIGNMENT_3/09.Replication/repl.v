module repl(
  input [1:0]a,b,c,
  output [6:0]y);

  assign y = {a,{4{b[0]}},c[1]};

endmodule
