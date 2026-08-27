module nand_gate(
  input a, b,
  output y
);
  supply0 gnd;  
  supply1 vdd;  
  wire w;

  pmos p1(y, vdd, a);
  pmos p2(y, vdd, b);
  nmos n1(w, gnd, a);
  nmos n2(y, w, b);

endmodule

