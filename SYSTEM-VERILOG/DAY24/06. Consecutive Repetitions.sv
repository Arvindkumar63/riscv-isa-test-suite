// Consecutive Repetitions
 module consec_repeat;

  bit [3:0] a;
   bit [2:0] values[] = '{2,3,2,2,4,4,4};

  covergroup cov_grp;
    c1 : coverpoint a {
      bins tran_1 = (2 [*2]); // Matches two consecutive occurrences of 2
      bins tran_2 = (4 [*3]); // Matches three consecutive occurrences of 4
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
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  3, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 0.00 
# KERNEL: val =  2, coverage % = 50.00 
# KERNEL: val =  4, coverage % = 50.00 
# KERNEL: val =  4, coverage % = 50.00 
# KERNEL: val =  4, coverage % = 100.00 
