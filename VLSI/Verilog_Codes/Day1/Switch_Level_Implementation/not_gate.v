module not_gate(input in, output out);
  supply0 a;
  supply1 b;
  pmos(out, b, in);
  nmos(out, a, in);
endmodule
