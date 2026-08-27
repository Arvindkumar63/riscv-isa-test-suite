// Coverpoint using the function return value 
class packet;
  randc bit[1:0] a;
  randc bit[1:0] b;
  
  function bit[2:0] sum(int a, int b);
    int c;
    c = a+b;
    return c;
  endfunction
  
  covergroup cg;
    c1: coverpoint a;
    c2: coverpoint b;
    func: coverpoint sum(a,b); // bin created for 3 bit : 8 combinations
  endgroup
  
  
  function new();
    cg = new();
  endfunction
  
endclass

module tb;
  int add;
  packet p;
  
  initial begin
    p = new();
    repeat(5) begin
      p.randomize();
      add = p.a + p.b;
      p.cg.sample();
      $display("a=%d b=%d sum=%0d coverage %%=%.2f",p.a,p.b,add,p.cg.get_inst_coverage());
    end
  end
endmodule


//OUTPUT
# KERNEL: a=1 b=0 sum=1 coverage %=20.83
# KERNEL: a=3 b=2 sum=5 coverage %=41.67
# KERNEL: a=0 b=1 sum=1 coverage %=58.33
# KERNEL: a=2 b=3 sum=5 coverage %=75.00
# KERNEL: a=2 b=2 sum=4 coverage %=79.17
