//----------arguments name mismatch------------------
class packet;
  bit[31:0] addr;
  bit [31:0] data;
  extern virtual function void display(bit[31:0] addr, bit[31:0] data);
endclass
    
    function void packet::display(bit[31:0] addr_t, bit[31:0] data_t);//Out of block declaration formal argument name mismatch (addr, addr_t).
      $display("Addr = %0d Data = %0d",addr,data);
    endfunction
  
module extern_method;
  initial begin
    packet p;
    p = new();
    p.addr = 10;
    p.data = 20;
    p.display(p.addr, p.data);
  end
endmodule
//OUTPUT
 ** Error: testbench.sv(8): Name of argument 'addr_t' for extern method 'display' does not match prototype.
** Error: testbench.sv(8): Name of argument 'data_t' for extern method 'display' does not match prototype.   
    
//----------arguments name match------------------
class packet;
  bit[31:0] addr; 
  bit[31:0] data;
  extern virtual function void display(bit[31:0] addr, bit[31:0] data);
endclass
    
    function void packet::display(bit[31:0] addr, bit[31:0] data); // Argument name matched here - no error
      $display("Addr = %0d Data = %0d",addr,data);
    endfunction
  
module extern_method;
  initial begin
    packet p;
    p = new();
    p.addr = 10;
    p.data = 20;
    p.display(p.addr, p.data);
    p.display(20,10);
  end

  //OUTPUT
  Addr = 10 Data = 20
  Addr = 20 Data = 10
endmodule
