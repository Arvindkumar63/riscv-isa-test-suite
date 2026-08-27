// // Instantiating virtual class lead to 
// //abstract class
// virtual class packet;
//   bit [31:0] addr;
// endclass
// module virtual_class;
//   packet p;
//   initial begin
//     p = new();// An abstract (virtual) class cannot be instantiated.
//   end
// endmodule

// Deriving virtual class
//abstract class
virtual class packet;
  bit [31:0] addr;
  function void display;
    $display("Value of addr is %0d", addr);
  endfunction
endclass
 
class extended_packet extends packet;
  bit [31:0] data;
  function void display;
    super.display();
    $display("Value of data is %0d", data);
  endfunction
endclass
 
module virtual_class;
  initial begin
    // packet p1 = new(); // Compilation error
    extended_packet p;
    p = new();
    p.addr = 10;
    p.data = 20;
    p.display();
  end
endmodule

// OUTPUT
Value of addr is 10
Value of data is 20
