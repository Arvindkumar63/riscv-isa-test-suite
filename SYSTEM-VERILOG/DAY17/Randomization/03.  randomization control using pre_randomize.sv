// randomization control using pre_randomize
class packet;
  rand bit [7:0] addr;
  randc bit wr_rd;
  bit tmp_wr_rd;
  
  function void pre_randomize();
    if(tmp_wr_rd == 1)
      addr.rand_mode(0);
    else
      addr.rand_mode(1);
  endfunction
  
  function void post_randomize();
    tmp_wr_rd = wr_rd;
    $display("post_randomization :: Addr = %0h, wr_rd = %0h",addr, wr_rd);
  endfunction
endclass

module rand_methods;
  initial begin
    packet pkt = new();
    repeat(4) 
      pkt.randomize();
  end
endmodule

//OUTPUT
post_randomization :: Addr = 6c, wr_rd = 0
post_randomization :: Addr = e6, wr_rd = 1
post_randomization :: Addr = e6, wr_rd = 0
post_randomization :: Addr = 3d, wr_rd = 1
post_randomization :: Addr = 3d, wr_rd = 1
post_randomization :: Addr = 3d, wr_rd = 0
post_randomization :: Addr = e6, wr_rd = 1
post_randomization :: Addr = e6, wr_rd = 0
post_randomization :: Addr = 16, wr_rd = 1
post_randomization :: Addr = 16, wr_rd = 0
