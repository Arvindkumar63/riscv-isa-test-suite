// Range of Repetition
module range_of_repeat_bin;

  bit [3:0] a;
  bit [2:0] value[$] = '{2,3,3,2,2,2,2,4,4};

  covergroup cvgrp;
    c1 : coverpoint a {
      bins tran_1 = (2 [*3:5]);
      bins tran_2 = (4 [*3]);
    }
  endgroup

  cvgrp cg = new();

  initial begin
    foreach(value[i]) begin
      a = value[i];
      cg.sample();
      $display("val = %d, coverage %% = %.2f ", a, cg.get_inst_coverage());
    end
  end
endmodule


//OUTPUT
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 50.00 
# KERNEL: val =  2, coverage % = 50.00 
# KERNEL: val =  4, coverage % = 50.00 
# KERNEL: val =  4, coverage % = 50.00 
