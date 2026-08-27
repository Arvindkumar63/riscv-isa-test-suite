// Ignore Bins
module ign_bins;
  bit[1:0] a;
  bit[1:0] value[] = '{0,1,2,3};
  
  covergroup cov_grp;
    c1: coverpoint a {
      ignore_bins b1 = {1,2};
    }
    
    /*c2: coverpoint a {
      ignore_bins b2 = (0=>1=>2);
      }*/ //It doesn't change the coverage value always this transition is only ignored not remove or ignore the values...
  endgroup
  
  cov_grp cg;
  
  initial begin
    cg = new();
    foreach(value[i]) begin
      a = value[i] ;
      cg.sample();
      $display("a=%d coverage%% =%.2f", a, cg.get_inst_coverage);
    end
  end
endmodule

//OUTPUT
# KERNEL: a=0 coverage% =25.00
# KERNEL: a=1 coverage% =50.00
# KERNEL: a=2 coverage% =75.00
# KERNEL: a=3 coverage% =100.00
