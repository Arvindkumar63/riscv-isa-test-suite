// Goto Repetition 
module goto_repeat;

  bit [3:0] a;
  bit [2:0] value[$] = '{1,2,3,4,3,4,2,3,4,5};

  covergroup cvgrp;
    c1 : coverpoint a {
      bins t1 = (1 => 4 [->3] => 5);// 5 should be immmediately after the last occurence of 4 
    }
  endgroup

  cvgrp cg = new();

  initial
  begin
    foreach(value[i])
    begin
      a = value[i];
      cg.sample();
      $display("val = %d, coverage %% = %.2f ", a, cg.get_inst_coverage());
    end
  end
endmodule

//OUTPUT
# KERNEL: val =  1, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  4, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  4, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  4, coverage % = 0.00 
# KERNEL: val =  5, coverage % = 100.00 
