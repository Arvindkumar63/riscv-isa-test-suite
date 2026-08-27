// this keyword usage in the static method is illegal. A compilation error is expected.
class transaction;
  bit [31:0] data;
  int id;
  
  static function assign_val (bit [31:0] data, int id);
    this.data = data;
    this.id = id;
  endfunction
endclass

module class_example;
  initial begin
    transaction tr = new();
    tr.assign_val(5,1);
    $display("Value of data = %0h, id = %0h", tr.data, tr.id);
  end
endmodule

//function static or task static method call, it is possible to use this keyword 
// function non static - only the variable is static this keyword is used here
class transaction;
  bit [31:0] data;
  int id;
  
  function static assign_val (bit [31:0] data, int id);
    this.data = data;
    this.id = id;
  endfunction
endclass

module class_example;
  initial begin
    transaction tr = new();
    tr.assign_val(5,1);
    $display("Value of data = %0h, id = %0h", tr.data, tr.id);
  end
endmodule
