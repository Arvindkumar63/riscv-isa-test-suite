module bidirectional_switch(
  input in_out1, ctrl, 
  output in_out2, in_out2_if0, in_out2_if1);
  
  tran t1(in_out1, in_out2);
  tranif0 t2(in_out1, in_out2_if0, ctrl);
  tranif1 t3(in_out1, in_out2_if1, ctrl);
endmodule
