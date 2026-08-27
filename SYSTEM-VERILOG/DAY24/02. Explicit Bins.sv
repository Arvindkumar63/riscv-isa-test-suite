// Explicit Bins
module explicit_bin;

  bit [2:0] a;

  covergroup cvgrp;
    c1 : coverpoint a {
      bins b1 = {2};
      bins b2 = {3};
    }
  endgroup

  cvgrp cg = new();

  initial begin
    for (int i = 1; i <= 5; i++) begin
      a = $random();
      cg.sample();
      $display("a = %d, coverage = %.2f %%", a, cg.get_inst_coverage());
    end
  end
endmodule

//OUTPUT
# KERNEL: a = 4, coverage = 0.00 %
# KERNEL: a = 1, coverage = 0.00 %
# KERNEL: a = 1, coverage = 0.00 %
# KERNEL: a = 3, coverage = 50.00 %
# KERNEL: a = 5, coverage = 50.00 %
