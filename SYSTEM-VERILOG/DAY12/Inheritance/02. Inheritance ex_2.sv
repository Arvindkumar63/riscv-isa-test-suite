// Inheritance ex-2
class parent_class;
  bit [31:0] addr = 5;
endclass

class child_class extends parent_class;
  bit [31:0] data = 10;
endclass

module inheritence;
  initial begin
    child_class c = new();
    //c.addr = 15;
    c.data = 20;
    $display("Value of addr = %0d data = %0d",c.addr,c.data);
  end
endmodule
