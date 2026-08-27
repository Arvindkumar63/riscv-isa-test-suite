// Conditional Coverage 
module cvgrp_iff;
  bit [2:0] a;
  bit [1:0] b;
  bit clk;
  
  always #5 clk = ~clk;
  
  covergroup cvgrp @(posedge clk);
    c1 : coverpoint a iff(b == 2) {
      bins b1 = {4};
      bins b2 = {5};
    }
  endgroup
  
  cvgrp cg = new();
  
  initial begin
    repeat(16) begin
      a = $random;
      b = $random;
      
      @(posedge clk);
      if(b==2)
        $display("-----------b == 2 is satisfied------------");
      $display("a = %d | b = %d | coverage %% = %.2f", a,b,cg.get_inst_coverage());
    end
    $finish;
  end
endmodule


//OUTPUT
# KERNEL: a = 4 | b = 1 | coverage % = 0.00
# KERNEL: a = 1 | b = 3 | coverage % = 0.00
# KERNEL: a = 5 | b = 1 | coverage % = 0.00
# KERNEL: -----------b == 2 is satisfied------------
# KERNEL: a = 5 | b = 2 | coverage % = 50.00
# KERNEL: a = 1 | b = 1 | coverage % = 50.00
# KERNEL: a = 6 | b = 1 | coverage % = 50.00
# KERNEL: a = 5 | b = 0 | coverage % = 50.00
# KERNEL: -----------b == 2 is satisfied------------
# KERNEL: a = 1 | b = 2 | coverage % = 50.00
# KERNEL: -----------b == 2 is satisfied------------
# KERNEL: a = 5 | b = 2 | coverage % = 50.00
# KERNEL: a = 5 | b = 3 | coverage % = 50.00
# KERNEL: a = 2 | b = 3 | coverage % = 50.00
# KERNEL: -----------b == 2 is satisfied------------
# KERNEL: a = 2 | b = 2 | coverage % = 50.00
# KERNEL: a = 0 | b = 1 | coverage % = 50.00
# KERNEL: a = 4 | b = 1 | coverage % = 50.00
# KERNEL: a = 5 | b = 1 | coverage % = 50.00
# KERNEL: -----------b == 2 is satisfied------------
# KERNEL: a = 3 | b = 2 | coverage % = 50.00
