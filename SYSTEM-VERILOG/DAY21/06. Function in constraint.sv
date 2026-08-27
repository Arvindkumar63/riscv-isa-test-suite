// Functions in constraint
class packet;
  rand bit [3:0] start_addr;
  rand bit [3:0] end_addr;
  
  constraint c1 { start_addr == s_addr(end_addr); 
                   }
  
  function bit[3:0] s_addr(bit [3:0] e_addr);
    if(e_addr < 4)
      s_addr = 0;
    else
      s_addr = e_addr - 4;
  endfunction
  
endclass

module func_const;
  initial begin
    packet pkt = new();
    repeat (6) begin
      pkt.randomize();
      $display("start_addr = %0d   end_addr = %0d ", pkt.start_addr, pkt.end_addr);
    end
  end
endmodule



//OUTPUT
start_addr = 0   end_addr = 4 
start_addr = 6   end_addr = 10 
start_addr = 4   end_addr = 8 
start_addr = 0   end_addr = 1 
start_addr = 2   end_addr = 6 
start_addr = 9   end_addr = 13 
      
