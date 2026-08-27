// Pass datatype to a Class
class packet #(parameter type T = int);
  T addr;
  T data;
  
  function new();
    addr = 10;
    data = 50;
  endfunction
  
  function void display();
    $display("-------------------------------------------------------------");
    $display("Type T = ", $typename(T)); // Display Datatype
    $display("ADDR = %0d", addr);
    $display("DATA = %0d", data);
    $display("-------------------------------------------------------------");
  endfunction
    
endclass
    
module param_data;
  packet #(bit[31:0]) pkt1; // Overriding parameter
  packet pkt2; // Takes Default type
  initial begin
    pkt1 = new();
    pkt2 = new();
    pkt1.display();//Expect type = bit[31:0]
    pkt2.display();//Expect type = int
  end
endmodule
