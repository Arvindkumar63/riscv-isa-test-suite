// Accessing local variable inside the class
class parent_class;
  local bit[31:0] tmp_addr;
  function new(bit [31:0] r_addr);
    tmp_addr = r_addr + 5;
  endfunction
  function void display();
    $display("tmp_addr = %0d", tmp_addr);
  endfunction
endclass

module encapsule;
  parent_class p1;
  initial begin
    p1 = new(10);
    p1.display();
  end
endmodule

//OUTPUT
tmp_addr = 15
