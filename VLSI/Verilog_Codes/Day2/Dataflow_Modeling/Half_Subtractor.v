module Half_Subtractor(
  input a,b,
  output dif,bor);

  assign dif = a^b;
  assign bor = ~a&b;

endmodule          
