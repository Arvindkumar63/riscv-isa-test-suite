module nor_switch(
  input a, b,
  output out);

  supply0 gnd;  
  supply1 vdd;   
  wire w;

  pmos p1(w, vdd, a);
  pmos p2(out, w, b);
  nmos n1(out, gnd, a);
  nmos n2(out, gnd, b);

endmodule

