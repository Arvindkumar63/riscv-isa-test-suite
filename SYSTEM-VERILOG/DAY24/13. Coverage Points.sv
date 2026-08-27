// Coverage Options
class sample;
  rand bit [2:0] a;
  rand bit [3:0] b;
endclass

sample s;

covergroup cgrp;
  c1: coverpoint s.a {
    bins b1 = {1};
    bins b2 = {2};
    option.at_least = 2;
  }
  
  c2: coverpoint s.a {
    option.weight = 2;
  }
  
  c3: coverpoint s.b {
    option.auto_bin_max = 2;
  }
endgroup

cgrp c;

module tb_opt;
  initial begin
    s = new();
    c = new();
    
    repeat (10) begin
      s.randomize();
      c.sample();
      
      $display("a = %d ; b = %d ; coverage %% = %.2f", s.a, s.b, c.get_inst_coverage());
      $display("coverpoint c1 coverage%% = %.2f%%", c.c1.get_coverage());
      $display("coverpoint c2 coverage%% = %.2f%%", c.c2.get_coverage());
      $display("coverpoint c3 coverage%% = %.2f%%", c.c3.get_coverage());
      $display("--------------------------------------------");
    end
  end
endmodule 

//OUTPUT
# KERNEL: a = 7 ; b =  3 ; coverage % = 18.75
# KERNEL: coverpoint c1 coverage% = 0.00%
# KERNEL: coverpoint c2 coverage% = 12.50%
# KERNEL: coverpoint c3 coverage% = 50.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 0 ; b =  9 ; coverage % = 37.50
# KERNEL: coverpoint c1 coverage% = 0.00%
# KERNEL: coverpoint c2 coverage% = 25.00%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 2 ; b =  6 ; coverage % = 43.75
# KERNEL: coverpoint c1 coverage% = 0.00%
# KERNEL: coverpoint c2 coverage% = 37.50%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 5 ; b =  5 ; coverage % = 50.00
# KERNEL: coverpoint c1 coverage% = 0.00%
# KERNEL: coverpoint c2 coverage% = 50.00%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 1 ; b =  2 ; coverage % = 56.25
# KERNEL: coverpoint c1 coverage% = 0.00%
# KERNEL: coverpoint c2 coverage% = 62.50%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 2 ; b =  5 ; coverage % = 68.75
# KERNEL: coverpoint c1 coverage% = 50.00%
# KERNEL: coverpoint c2 coverage% = 62.50%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 7 ; b =  1 ; coverage % = 68.75
# KERNEL: coverpoint c1 coverage% = 50.00%
# KERNEL: coverpoint c2 coverage% = 62.50%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 2 ; b = 14 ; coverage % = 68.75
# KERNEL: coverpoint c1 coverage% = 50.00%
# KERNEL: coverpoint c2 coverage% = 62.50%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 2 ; b =  7 ; coverage % = 68.75
# KERNEL: coverpoint c1 coverage% = 50.00%
# KERNEL: coverpoint c2 coverage% = 62.50%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
# KERNEL: a = 0 ; b = 13 ; coverage % = 68.75
# KERNEL: coverpoint c1 coverage% = 50.00%
# KERNEL: coverpoint c2 coverage% = 62.50%
# KERNEL: coverpoint c3 coverage% = 100.00%
# KERNEL: --------------------------------------------
