// Start and Stop Function
class packet;
  randc bit [2:0] a;
  randc bit b;
endclass

covergroup cgrp;
  c1: coverpoint p.a;
  c2: coverpoint p.b;
endgroup

packet p;
cgrp c;

module cgrp_start_stop;
  initial begin
    p = new();
    c = new();
    c.start();
    repeat(5) begin
      p.randomize();
      c.sample();
      $display("a=%0d | b=%0d | coverage =%.2f",p.a,p.b,c.get_inst_coverage());
      
      if(c.get_inst_coverage() > 65 ) begin
        c.stop();
        $display("If coverage%% is greater than 65%%, stop executing covergroup");
      end
      
    end
  end
endmodule


//OUTPUT
# KERNEL: a=5 | b=1 | coverage =31.25
# KERNEL: a=4 | b=0 | coverage =62.50
# KERNEL: a=7 | b=0 | coverage =68.75
# KERNEL: If coverage% is greater than 65%, stop executing covergroup
# KERNEL: a=3 | b=1 | coverage =68.75
# KERNEL: If coverage% is greater than 65%, stop executing covergroup
# KERNEL: a=1 | b=1 | coverage =68.75
# KERNEL: If coverage% is greater than 65%, stop executing covergroup
