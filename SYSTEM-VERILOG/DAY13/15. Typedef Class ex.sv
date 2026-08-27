// Without Typedef Class
class c1;
  c2 c; // Using c2 handle before Declaring it 
endclass

class c2;
  c1 c;
endclass

module typedef_class;
  initial begin
    c1 class1;
    c2 class2;
    $display("Inside Typedef- Class");
  end
endmodule
//** Error: testbench.sv(3): Invalid type 'c2'. Please check the type of the variable 'c'.

//With Typedef Class
typedef class c2;
class c1;
  c2 c; 
endclass

class c2;
  c1 c;
endclass

module typedef_class;
  initial begin
    c1 class1;
    c2 class2;
    $display("Inside Typedef- Class");
  end
endmodule
  //OUTPUT:
  //Inside Typedef- Class
