module mux_tg(
  input i0, i1, s,
  output y);
  wire sb;
  
  not_gate G1(.out(sb), .in(s));
  cmos TG0(y, i0, sb ,s);
  cmos TG1(y, i1, s ,sb);

endmodule
