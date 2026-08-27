//Scope resolution operator
class packet;
  bit [31:0] addr;
  static bit [31:0] id;

  static function display(bit [31:0] a,b);
    $display("Values are %0d %0d",a,b);
  endfunction
endclass

module scope_res;
  int id=10;
  initial begin
   // packet::addr; // Illegal to access non-static property 'addr' outside its class scope.
    packet::id = 20; // Access the static members without creating the object.
    packet::display(packet::id,id);
  end
endmodule

//OUTPUT
Values are 20 10
