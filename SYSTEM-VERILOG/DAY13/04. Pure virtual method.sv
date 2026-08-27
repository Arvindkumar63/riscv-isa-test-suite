// pure virtual method
virtual class A; // always an abstract class when pure vitual method is used
  int a,b,c;
  pure virtual function void disp(); // not allowed to add function definition
    pure virtual task sum();
endclass
 
class B extends A;
  virtual function void disp();// compulsary to overriden the pure virtual class
    a =10; b=10;
    $display("1.Value of a = %0d, b = %0d, c = %0d",a,b,c);
  endfunction 
  virtual task sum();
    c = a+b;
    $display("2.Value of a = %0d, b = %0d, c = %0d",a,b,c);
  endtask 
endclass
 
module pure_vir_fun();
  B b1;
  initial begin
    b1 = new();
    b1.disp();
    b1.b = 35;
    b1.sum();
  end 
endmodule

// OUTPUT
1.Value of a = 10, b = 10, c = 0
2.Value of a = 10, b = 35, c = 45
