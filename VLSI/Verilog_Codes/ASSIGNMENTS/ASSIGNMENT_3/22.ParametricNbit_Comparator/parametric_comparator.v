module parametric_comparator #(parameter N = 4) 
  (input  [N-1:0] a,b,
   output eq,lt,gt);

  assign eq = (a == b);
  assign lt = (a < b);
  assign gt = (a > b);

endmodule

