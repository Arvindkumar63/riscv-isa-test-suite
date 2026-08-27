// Coverpoint using expression
module exp;
  bit [1:0] a;
  bit [2:0] b;
  
  covergroup cg;
    c1: coverpoint a;
    c2: coverpoint b;
    c3: coverpoint a*b; // 3- bit number..Only consider 8 combinations 
    c4: coverpoint a+b; // 3- bit number..Only consider 8 combinations 
  endgroup
  
  cg cg_inst;
  
  initial begin
    cg_inst = new();
    
    repeat(10) begin
      a = $random ;
      b = $random ;
      cg_inst.sample();
      $display("a=%d b=%d prod=%d sum=%d coverage %% = %.2f",a,b,a*b,a+b,cg_inst.get_inst_coverage);
    end
  end
endmodule


//OUTPUT
# KERNEL: a=0 b=1 prod=0 sum=1 coverage % = 15.62
# KERNEL: a=1 b=3 prod=3 sum=4 coverage % = 31.25
# KERNEL: a=1 b=5 prod=5 sum=6 coverage % = 40.62
# KERNEL: a=1 b=2 prod=2 sum=3 coverage % = 50.00
# KERNEL: a=1 b=5 prod=5 sum=6 coverage % = 50.00
# KERNEL: a=2 b=5 prod=2 sum=7 coverage % = 59.38
# KERNEL: a=1 b=4 prod=4 sum=5 coverage % = 68.75
# KERNEL: a=1 b=6 prod=6 sum=7 coverage % = 75.00
# KERNEL: a=1 b=2 prod=2 sum=3 coverage % = 75.00
# KERNEL: a=1 b=7 prod=7 sum=0 coverage % = 84.38
