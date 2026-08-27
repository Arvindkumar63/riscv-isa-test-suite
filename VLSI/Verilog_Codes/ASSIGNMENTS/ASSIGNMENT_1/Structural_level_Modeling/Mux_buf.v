module Mux_buf(
  input sel,i0,i1,
  output y);
  
  bufif0(y,i0,sel);
  bufif1(y,i1,sel);
 
endmodule

