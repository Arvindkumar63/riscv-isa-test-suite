module parametricmux #(parameter N = 4) 
  (input  [N-1:0] d0, d1, d2, d3,
   input  s0, s1,
   output [N-1:0] y);

  assign y = s1 ? (s0 ? d3 : d2) : (s0 ? d1 :d0);

endmodule

