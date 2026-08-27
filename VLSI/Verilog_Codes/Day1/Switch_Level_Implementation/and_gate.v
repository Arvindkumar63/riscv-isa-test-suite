module and_gate(
  input a, b,
  output y
);
  supply0 gnd;
  supply1 vdd;
  wire w,o;
   
   //nand
  pmos p1(o, vdd, a);
  pmos p2(o, vdd, b);
  nmos n1(w, gnd, a);
  nmos n2(o, w, b);
 
    //~NAND
  pmos p3(y,vdd,o);
  nmos n3(y,gnd,o);

endmodule
