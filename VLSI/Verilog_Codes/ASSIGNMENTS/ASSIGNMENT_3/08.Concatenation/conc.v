module conc(
  input [1:0]a,b,c,
  output [3:0]y);

  assign y = {a,b[0],c[1]};

endmodule 
