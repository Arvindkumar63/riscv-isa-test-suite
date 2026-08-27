// Pre and Post Randomize method
class packet;
  rand bit[7:0] addr;
  randc bit [7:0] data;
  
  //pre randomize function
  function void pre_randomize();
    $display("Inside pre_randomize");
  endfunction
  
  //post randomize function
  function void post_randomize();
    $display("Inside post_randomize");
    $display("value of addr = %0d |data = %0d", addr, data);
  endfunction
endclass

module rand_methods;
  initial begin
    packet pkt = new();
    pkt.randomize();
  end
endmodule

//OUTPUT
Inside pre_randomize
Inside post_randomize
value of addr = 108 |data = 18
