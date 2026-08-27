// Accessing a protected variable in the extended class (Allowed)
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
    child_class c_c = new(15);
    
    c_c.incr_addr();  //Accessing protected variable in extended class
    c_c.display();
  end
endmodule

//OUTPUT
tmp_addr = 21
