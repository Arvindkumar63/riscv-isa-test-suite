// Coverpoint using part select
module part_select;
  bit [2:0] a;

  covergroup cg;
    a1: coverpoint a[1:0];
    a2: coverpoint a[0];
    a3: coverpoint a[2:1];
  endgroup

  cg cg_inst;

  initial begin
    cg_inst = new();
    repeat(5) begin
      a = $random;
      cg_inst.sample();
      $display("a=%d a1=%b a2=%b a3=%b coverage %%=%0.2f", a, a[1:0], a[0], a[2:1], cg_inst.get_coverage());
    end
  end
endmodule

//OUTPUT
# KERNEL: a=4 a1=00 a2=0 a3=10 coverage %=33.33
# KERNEL: a=1 a1=01 a2=1 a3=00 coverage %=66.67
# KERNEL: a=1 a1=01 a2=1 a3=00 coverage %=66.67
# KERNEL: a=3 a1=11 a2=1 a3=01 coverage %=83.33
# KERNEL: a=5 a1=01 a2=1 a3=10 coverage %=83.33
