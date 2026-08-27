module Full_Adder(
  input a,b,c,
  output s,c_out);

  assign s = a^b^c;
  assign c_out = (a&b)|(b&c)|(c&a);

endmodule
