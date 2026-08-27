// Covergroup defined inside a module
class packet;
  rand bit[1:0]a;
  rand bit[2:0]b;
endclass

module cvgrp_inside_mod;
  packet pkt;
  covergroup cgrp(ref bit [1:0] a, ref bit [2:0] b);
    c1: coverpoint a;
    c2: coverpoint b;
  endgroup

  cgrp c;
  initial begin
    pkt = new();
    c = new(pkt.a, pkt.b);

    repeat (5) begin
      void'(pkt.randomize());
      c.sample();
      $display("a=%d ; b=%d ; coverage %%= %.2f%%", pkt.a, pkt.b, c.get_inst_coverage());
    end
    $finish;
  end
endmodule


//OUTPUT
# KERNEL: a=3 ; b=4 ; coverage %= 18.75%
# KERNEL: a=1 ; b=6 ; coverage %= 37.50%
# KERNEL: a=2 ; b=3 ; coverage %= 56.25%
# KERNEL: a=2 ; b=3 ; coverage %= 56.25%
# KERNEL: a=2 ; b=0 ; coverage %= 62.50%
