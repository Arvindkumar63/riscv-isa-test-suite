// CoverGroup ex1

module cvr_grp;
  bit[1:0] a;
  bit[1:0] b;
  
  covergroup cgrp;
    c1: coverpoint a;
    c2: coverpoint b;
  endgroup
  
  cgrp cg;
  
  initial begin
    cg = new();
    
    repeat(5) begin
      a = $random() % 4;
      b = $random() % 4;
      
      cg.sample(); // Sample Coverage
      
      //Display current instance coverage percentage 
      $display("a = %0d | b = %0d | coverage %% = %.2f", a,b, cg.get_inst_coverage());
    end
    
    //Display overall functional coverage percentage
    $display("Overall functional coverage = %.2f%%", cg.get_coverage());
  end
endmodule

//OUTPUT
# KERNEL: a = 0 | b = 1 | coverage % = 25.00
# KERNEL: a = 1 | b = 3 | coverage % = 50.00
# KERNEL: a = 1 | b = 1 | coverage % = 50.00
# KERNEL: a = 1 | b = 2 | coverage % = 62.50
# KERNEL: a = 1 | b = 1 | coverage % = 62.50
# KERNEL: Overall functional coverage = 62.50%
    
    
      
