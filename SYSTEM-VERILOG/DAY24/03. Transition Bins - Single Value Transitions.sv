// Transition Bins - Single Value Transitions

module sing_val_trans;

  bit [3:0] a;
  bit [2:0] value[$] = '{1,2,3,4};

  covergroup cvgrp;
    c1 : coverpoint a {
      bins tran_1 = (1 => 2);
      bins tran_2 = (3 => 4);
    }
  endgroup

  cvgrp cg = new();

  initial begin
    foreach (value[i]) begin
      a = value[i];
      cg.sample();
      $display("val = %d, cov = %.2f %%", a, cg.get_inst_coverage());
    end
  end
endmodule  

//OUTPUT
# KERNEL: val =  1, cov = 0.00 %
# KERNEL: val =  2, cov = 50.00 %
# KERNEL: val =  3, cov = 50.00 %
# KERNEL: val =  4, cov = 100.00 %
