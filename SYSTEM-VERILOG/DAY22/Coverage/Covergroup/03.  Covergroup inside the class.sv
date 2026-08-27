// Covergroup inside the class

class packet;
  rand bit [1:0] a; 
  rand bit [1:0] b; 

  covergroup cg;
    c1: coverpoint a; 
    c2: coverpoint b; 
  endgroup

  function new();
    cg = new();
  endfunction
endclass

packet p = new();

module cvgrp_inside_class;
  initial begin
    repeat (5) begin
      void'(p.randomize()); 
      p.cg.sample(); 

      $display("a=%d ; b=%d ; coverage %%=%.2f", p.a, p.b, p.cg.get_inst_coverage());
    end
  end
endmodule

//OUTPUT
# KERNEL: a=1 ; b=1 ; coverage %=25.00
# KERNEL: a=2 ; b=0 ; coverage %=50.00
# KERNEL: a=0 ; b=1 ; coverage %=62.50
# KERNEL: a=0 ; b=2 ; coverage %=75.00
