module comparator(
  output Eq, Less, Greater,
  input [1:0] a,b);
  wire x0, x1, x2, x3;
  wire w0, w1;
  wire nb0, nb1;
  wire na0, na1;
  wire l1,l0,g1,g0;

   // inverters
  not(na0, a[0]);
  not(na1, a[1]);
  not(nb0, b[0]);
  not(nb1, b[1]);

    //Equality output
  and(x0, na0, nb0);
  and(x1, a[0], b[0]);
  and(x2, na1, nb1);
  and(x3, a[1], b[1]);
  or(w0, x0, x1);
  or(w1, x2, x3);
  and(Eq, w0, w1);

    //Lesser output
  and(l1, na1, b[1]);
  and(l0, w1, na0, b[0]);
  or(Less, l1, l0);

    //Greater output
  and(g1, nb1, a[1]);
  and(g0, w1, nb0, a[0]);
  or(Greater, g1, g0);

endmodule
