module Full_Subtractor(
  input a,b,c,
  output dif,bor);

  assign dif = a^b^c;
  assign bor = ((a~^b)&c) | (~a&b);

endmodule
