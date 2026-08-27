// Deep Copy
//copies all the class members and its nested class members
class address_range;
  bit [31:0] start_address;
  bit [31:0] end_address;
  
  function new();
    start_address = 10;
    end_address =50;
  endfunction
  
    //Copy method
  function address_range copy;
    copy = new();
    copy.start_address = this.start_address;
    copy.end_address = this.end_address;
    return copy;
  endfunction
endclass

class packet;
  bit[31:0] addr;
  bit [31:0] data;
  address_range ar;
  
  function new();
    addr = 40;
    data = 70;
    ar = new();
  endfunction
  
  function packet copy;
    copy = new();
    copy.addr = this.addr;
    copy.data = this.data;
    copy.ar = ar.copy;
    return copy;
  endfunction
  
  function void display();
    $display("---------------------------------------------------------");
    $display("\t addr = %0d", addr);
    $display("\t data = %0d", data);
    $display("\t start_address = %0d", ar.start_address);
    $display("\t end_address = %0d", ar.end_address);
    $display("---------------------------------------------------------");
  endfunction
endclass
  
module deep_copy;
  packet pkt1;
  packet pkt2;
  initial begin
    pkt1 = new();
    $display("----------------calling pkt1 display-----------------");
    pkt1.display();
    pkt2 = new();
    $display("----------------calling pkt2 display-----------------");
    pkt2.display();
    
    pkt2 = pkt1.copy;
    pkt2.addr = 54;
    pkt2.ar.start_address = 60;
    pkt2.ar.end_address = 80;
    $display("----------------calling pkt1 display-----------------");
    pkt1.display();
    $display("----------------calling pkt2 display-----------------");
    pkt2.display();
  end
endmodule
