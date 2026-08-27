// Super Keyword
class parent_class;
  bit [31:0] addr;
  function display();
    $display("Addr = %0d",addr);
  endfunction
endclass

class child_class extends parent_class;
  bit [31:0] data;
  function display();
    super.display();//access parentclass method
    $display("Data = %0d",data);
  endfunction
endclass

module super_key;
  initial begin
    child_class c=new();
    c.addr = 10;
    c.data = 20;
    c.display();
  end
endmodule

//OUTPUT
Addr = 10
Data = 20
