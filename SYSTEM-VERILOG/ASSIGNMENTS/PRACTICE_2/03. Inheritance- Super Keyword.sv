// Inheritance - Super keyword
class BaseClass;
  bit [7:0] id;
  function void display();
    $display("Base Class ID = %0d",id);
  endfunction
endclass

class DerivedClass extends BaseClass;
  function void display();
    super.display();
    $display("Derived Class");
  endfunction
endclass

module example;
  DerivedClass obj = new();
  initial begin
    obj.id = 50;
    obj.display();
  end
endmodule

// OUTPUT
Base Class ID = 50
Derived Class
