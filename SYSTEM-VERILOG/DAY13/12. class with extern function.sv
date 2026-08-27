//class with extern function
class packet;
  bit [31:0] addr;
  bit [31:0] data;
  //extern indicates out-of-body declaration
  extern virtual function void display();
endclass

//function implementation outside class body
function void packet::display();
  $display("Addr = %0d Data = %0d",addr,data);
endfunction
  
module extern_method;
  initial begin
    packet p;
    p = new();
    p.addr = 10;
    p.data = 20;
    p.display();
  end
endmodule

//OUTPUT
Addr = 10 Data = 20
