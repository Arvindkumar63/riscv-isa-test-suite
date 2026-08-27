// Cross Coverage 
class packet;
  rand bit a;
  rand bit b;
  
  covergroup cg;
    c1:coverpoint a;
    c2: coverpoint b;
    c3: cross c1, c2;
  endgroup
  
  function new();
    cg = new();
  endfunction
  
endclass

module cross_cover;
  packet pkt;
  initial begin
    pkt = new();
    repeat(5) begin
      void'(pkt.randomize());
      pkt.cg.sample();
      $display("a = %d; b = %d; coverage %% = %.2f ", pkt.a,pkt.b,pkt.cg.get_inst_coverage());
    end
  end
endmodule


//OUTPUT
# KERNEL: a = 1; b = 0; coverage % = 41.67 
# KERNEL: a = 1; b = 0; coverage % = 41.67 
# KERNEL: a = 1; b = 1; coverage % = 66.67 
# KERNEL: a = 1; b = 1; coverage % = 66.67 
# KERNEL: a = 1; b = 0; coverage % = 66.67
