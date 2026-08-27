// Parameterized Class
class packet #(parameter int size = 8);
  bit [size-1:0] addr;
  bit [size-1:0] data;
  
  function new();
    addr = 10;
    data = 50;
  endfunction
  
  function void display();
    $display("-------------------------------------------------------------");
    $display("SIZE = %0d", size);
    $display("ADDR = %0d", addr);
    $display("DATA = %0d", data);
    $display("-------------------------------------------------------------");
  endfunction
endclass

module param;
  packet #(10) pkt1; // Overriding parameter
  packet pkt2; // Takes Default value
  initial begin
    pkt1 = new();
    pkt2 = new();
    pkt1.display();//Expect size = 10
    pkt2.display();//Expect size = 8
  end
endmodule
