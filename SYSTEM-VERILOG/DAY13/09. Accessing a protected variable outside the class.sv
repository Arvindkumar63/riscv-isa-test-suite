// Accessing a protected variable outside the class(Not Allowed)
class parent_class;
  protected bit[31:0] tmp_addr;
  function new(bit [31:0] r_addr);
    tmp_addr = r_addr + 5;
  endfunction  
  function void display();
    $display("tmp_addr = %0d", tmp_addr);
  endfunction
endclass

class child_class extends parent_class;
  function new(bit[31:0] r_addr);
    super.new(r_addr);
  endfunction
  function void incr_addr();
    tmp_addr++;
  endfunction
endclass

module encap;
  initial begin
    parent_class p_c = new(10);
    child_class c_c = new(15);
    
    p_c.tmp_addr = 30; // variable declared as protected cannot be accessed outside the class  // Illegal access to protected member tmp_addr
    p_c.display();
    
    c_c.incr_addr();  //Accessing protected variable in extended class
    c_c.display();
  end
endmodule

//OUTPUT
** Error (suppressible): (vlog-8688) testbench.sv(26): Illegal access to protected member tmp_addr
