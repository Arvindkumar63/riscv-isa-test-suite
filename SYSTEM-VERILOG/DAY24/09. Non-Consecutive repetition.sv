// Non-Consecutive repetition
module non_cons_repeat;

  bit [3:0] a;
  bit [2:0] values[$] = '{3,2,3,4,3,4,2,3,4,5};

  covergroup cov_grp;
    c1 : coverpoint a {
      bins tran_1 = (3[=4] => 5); // 5 need not be immmediately after the last occurence of 4 
    }
  endgroup

  cov_grp cg = new();

  initial begin
    foreach(values[i]) begin
      a = values[i];
      cg.sample();
      $display("val = %d, coverage %% = %.2f ", a, cg.get_inst_coverage());
    end
  end
endmodule



//OUTPUT
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  4, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  4, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  4, coverage % = 0.00 
# KERNEL: val =  5, coverage % = 100.00
