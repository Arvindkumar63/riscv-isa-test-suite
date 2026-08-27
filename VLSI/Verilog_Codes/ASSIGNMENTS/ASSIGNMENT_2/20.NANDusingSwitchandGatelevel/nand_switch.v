module nand_switch(
  input a, b,
  output out
);
  supply0 gnd;  
  supply1 vdd;  
  wire w;

  pmos p1(out, vdd, a);
  pmos p2(out, vdd, b);
  nmos n1(w, gnd, a);
  nmos n2(out, w, b);

endmodule

