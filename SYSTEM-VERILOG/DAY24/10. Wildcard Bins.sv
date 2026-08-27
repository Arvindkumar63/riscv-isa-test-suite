// WildCard Bins
module wildcard_bin;

  bit [3:0] a;
  bit [3:0] values[] = '{4'b1101, 4'b1000, 4'b1001, 4'b1010, 4'b1011};

  covergroup cov_grp;
    c1 : coverpoint a {
      wildcard bins b1 = {4'b100x};
      wildcard bins b2 = {4'b101?};
    }
  endgroup

  cov_grp cg = new();

  initial
  begin
    foreach(values[i])
    begin
      a = values[i];
      cg.sample();
      $display("val = %d, coverage %% = %.2f ", a, cg.get_inst_coverage());
    end
  end
endmodule

//OUTPUT
# KERNEL: val = 13, coverage % = 0.00 
# KERNEL: val =  8, coverage % = 50.00 
# KERNEL: val =  9, coverage % = 50.00 
# KERNEL: val = 10, coverage % = 100.00 
# KERNEL: val = 11, coverage % = 100.00 
