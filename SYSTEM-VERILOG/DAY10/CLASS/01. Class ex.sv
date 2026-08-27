// Class Example
class sv_class;
  int x; //class properties
  
  task set(int i);//method 1
    x = i;
  endtask
  
  function int get(); //method 2
    return x;
  endfunction
endclass


module class_ex;
  sv_class c1;// Creating handle
  initial begin
    sv_class c2 = new(); // Creating handle and object
    c1 = new();// Creating object for the handle
    
    //Accessing class methods
    c1.set(10);
    c2.set(20);
    $display("c1: Value of x is %0d",c1.get());
    $display("c2: Value of x is %0d",c2.get());
  end
endmodule
