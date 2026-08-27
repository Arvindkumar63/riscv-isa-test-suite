// Illegal Bins
module ill_bins;
  bit [1:0] a;
  bit[1:0] value[] = '{0,1,2,3};
  
  covergroup cov_grp ;
    c1: coverpoint a {
      illegal_bins b1 = {2};//Lead to runtime error
    }
  endgroup
  
  cov_grp cg = new();
  
  initial begin
    foreach(value[i]) begin
      a = value[i];
      cg.sample();
      $display("a=%d coverage %%= %.2f", a,cg.get_inst_coverage());
    end
  end
endmodule


      //OUTPUT
# KERNEL: a=0 coverage %= 33.33
# KERNEL: a=1 coverage %= 66.67
# ACDB: Error: ACDB_0012 testbench.sv (8): Illegal bin 'b1' was hit with value '2' at iteration #2 of covergroup sampling. It will have no impact on the coverage statistics. HDL instance: "/ill_bins". Covergroup type: "cov_grp", covergroup instance: "<UNNAMED1>", coverpoint: "c1".
# KERNEL: a=2 coverage %= 66.67
# KERNEL: a=3 coverage %= 100.00
