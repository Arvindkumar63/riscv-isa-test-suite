// Triggering Cover Group
module cvgrp_using_clk;
  bit [2:0]a;
  bit b;
  bit clk;
  
  always #5 clk = ~clk;
  
  covergroup cvgp @(posedge clk);
    c1: coverpoint a;
    c2: coverpoint b;
  endgroup
  
  cvgp cg = new();
  
  initial begin
    repeat (5) begin
      @(posedge clk);
      a = $random;
      b = $random;
       
      $display("a=%0d b=%0d ; coverage = %0.2f",a,b,cg.get_inst_coverage());
    end
    $finish;
  end
endmodule


//OUTPUT
# KERNEL: a=4 b=1 ; coverage = 31.25
# KERNEL: a=1 b=1 ; coverage = 62.50
# KERNEL: a=5 b=1 ; coverage = 68.75
# KERNEL: a=5 b=0 ; coverage = 75.00
# KERNEL: a=1 b=1 ; coverage = 75.00
