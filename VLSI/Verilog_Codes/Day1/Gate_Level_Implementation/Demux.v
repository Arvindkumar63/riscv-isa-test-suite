module Demux(
  input din, s0, s1,
  output y0, y1, y2, y3);
  wire ns0, ns1;

  not (ns0, s0);
  not (ns1, s1);

  and (y0, din, ns0, ns1);
  and (y1, din, s0, ns1);
  and (y2, din, ns0, s1);
  and (y3, din, s0, s1);

endmodule

