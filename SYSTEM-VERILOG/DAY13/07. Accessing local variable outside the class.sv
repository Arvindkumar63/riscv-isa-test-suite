// Accessing local variable outside the class
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
    p1.tmp_addr = 20;// Accessing local variable outside the class - Illegal access to local member tmp_addr
    p1.display();
  end
endmodule

//OUTPUT
** Error (suppressible): (vlog-8688) testbench.sv(16): Illegal access to local member tmp_addr
