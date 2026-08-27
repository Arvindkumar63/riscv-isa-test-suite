module Mux4to1(
  input i0, i1, i2, i3,
  input s0, s1,
  output y);
  wire ns0, ns1, w0, w1, w2, w3;

  not (ns0, s0);
  not (ns1, s1);

  and (w0, i0, ns0, ns1);
  and (w1, i1, s0, ns1);
  and (w2, i2, ns0, s1);
  and (w3, i3, s0, s1);
  or (y, w0, w1, w2, w3);

endmodule

