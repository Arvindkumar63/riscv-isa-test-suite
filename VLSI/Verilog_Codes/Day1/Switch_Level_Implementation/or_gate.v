module or_gate(
  input a, b,
  output y);

  supply0 gnd;
  supply1 vdd;
  wire w,o;

    //nor
  pmos p1(w, vdd, a);
  pmos p2(o, w, b);
  nmos n1(o, gnd, a);
  nmos n2(o, gnd, b);

    //~NOR
  pmos p3(y, vdd, o);
  nmos n3(y, gnd, o);

endmodule
