module nor_gate(
  input a, b,
  output y);

  supply0 gnd;  
  supply1 vdd;   
  wire w;

  pmos p1(w, vdd, a);
  pmos p2(y, w, b);
  nmos n1(y, gnd, a);
  nmos n2(y, gnd, b);

endmodule

