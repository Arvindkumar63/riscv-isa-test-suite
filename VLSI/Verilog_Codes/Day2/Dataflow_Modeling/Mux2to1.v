module Mux2to1(
  input i0,i1,sel,
  output y_cond,y_bitwise);

  assign y_cond= sel ? i1 : i0;           //using conditional operator
  assign y_bitwise= (~sel&i0)|(sel&i1);   // using bitwise operator

endmodule
