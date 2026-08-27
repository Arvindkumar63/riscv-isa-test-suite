module Half_Adder(
  output s, c_out, 
  input a, b);

  xor(s,a,b);
  and(c_out, a, b);

endmodule

