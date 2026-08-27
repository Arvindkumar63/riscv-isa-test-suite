module xor_gate(
  input a, b,
  output y);
  wire na, nb;     
 
  not_gate G1(.out(na), .in(a));
  not_gate G2(.out(nb), .in(b));

     // a & ~b
  cmos tg1(y, a, nb, b);

    // ~a & b
  cmos tg2(y, na, b, nb);

endmodule

