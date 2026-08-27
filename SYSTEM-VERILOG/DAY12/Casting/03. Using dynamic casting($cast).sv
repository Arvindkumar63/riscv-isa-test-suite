// Using $cast
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
    parent_class p;
    child_class  c=new();
    child_class  c1;
    c.addr = 10;
    c.data = 20;

    p = c;         //p is pointing to child class handle c.
    //c1 = p; // Lead to compile error - Types are not assignment compatible
    $cast(c1,p);   //with the use of $cast, type chek will occur during runtime
    c.display();
    p.display();
    c1.display();
  end
endmodule

// OUTPUT
Addr = 10
Data = 20

Addr = 10

Addr = 10
Data = 20
