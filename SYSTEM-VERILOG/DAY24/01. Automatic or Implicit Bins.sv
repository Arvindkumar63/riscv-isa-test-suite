// Coverage Bins
//Automatic or Implicit Bins
module cov_bins;
  
  bit [2:0] a;

  covergroup cvgrp;
    c1 : coverpoint a;
  endgroup

  cvgrp cg = new();

  initial begin
    repeat (5) begin
      a = $random();
      cg.sample();
      $display("a = %d, coverage = %.2f %%", a, cg.get_inst_coverage());
    end
  end
endmodule


//OUTPUT
# KERNEL: a = 4, coverage = 12.50 %
# KERNEL: a = 1, coverage = 25.00 %
# KERNEL: a = 1, coverage = 25.00 %
# KERNEL: a = 3, coverage = 37.50 %
# KERNEL: a = 5, coverage = 50.00 %
