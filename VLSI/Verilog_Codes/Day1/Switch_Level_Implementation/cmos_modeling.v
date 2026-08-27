module cmos_modeling (
  input d_in, p_ctrl, n_ctrl, 
  output out);
  
  cmos(out, d_in, n_ctrl, p_ctrl);
  
endmodule
