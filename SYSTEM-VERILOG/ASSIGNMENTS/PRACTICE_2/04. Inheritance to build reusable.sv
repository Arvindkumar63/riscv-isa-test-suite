// Inheritance to build reusable
class Basedriver;
  virtual function void drive(input bit[7:0] data);
    $display("Driving data = %0h",data);
  endfunction
endclass

class Customdriver extends Basedriver;
  function void drive(input bit[7:0] data);
    $display("Custom Driving data = %0h",data);
    super.drive(data); // Call base Class method
  endfunction
endclass

module inherit;
  initial begin
    Customdriver drv = new();
    drv.drive(8'h65);
  end
endmodule

//OUTPUT
Custom Driving data = 65
Driving data = 65
