// Assigning child class handle to parent class
class parent_class;
  bit [31:0] addr;
  function display();
    $display("Addr = %0d",addr);
  endfunction
endclass

class child_class extends parent_class;
  bit [31:0] data;
  function display();
    super.display();
    $display("Data = %0d",data);
  endfunction
endclass

module inheritence;
  initial begin
    parent_class p=new();
    child_class  c=new();
    c.addr = 10;
    c.data = 20;
    p = c;        //assigning child class handle to parent class handle
    c.display();
    p.display();
  end
endmodule

// OUTPUT
Addr = 10
Data = 20
Addr = 10

---------------------------------------------------------------------------
class parent_class;
  bit [31:0] addr;
  function display();
    $display("Addr = %0d",addr);
  endfunction
endclass

class child_class extends parent_class;
  bit [31:0] data;
  function display();
    super.display();
    $display("Data = %0d",data);
  endfunction
endclass

module inheritence;
  initial begin
    parent_class p=new();
    child_class  c=new();
    c.addr = 10;
    c.data = 20;
    //p = c;        //assigning child class handle to parent class handle
    c.display();
    p.display();
  end
endmodule

//OUTPUT
Addr = 10
Data = 20
Addr = 0
