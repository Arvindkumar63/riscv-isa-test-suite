module switch_modeling(p_out,n_out,data,ctrl);
  input data,ctrl;
  output p_out,n_out;
  pmos p1(p_out,data,ctrl);
  nmos n1(n_out,data,ctrl);
endmodule
