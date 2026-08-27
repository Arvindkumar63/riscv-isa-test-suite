// Clone method in a class to perform a deep copy 
class MyClass;
  int data;
  MyClass nested;
  function new (int d,MyClass n = null);
    data = d;
    nested = n;
    $display("Data = %0d", data);
    if(nested != null)
      $display("Nested Data = %0d ", nested.data); //Fatal Error when no if condition
  endfunction
  
  function MyClass clone();   // Deep copy clone method
    MyClass copy = new(data);
    if(nested != null) begin
      copy.nested = nested.clone(); // Recursively clone nested classes
     $display(" Cloned Nested  Data ", copy.nested.data);
    end
      $display(" Cloned Data ", copy.data);
    return copy;
  endfunction
endclass

module example;
  initial begin
    MyClass obj1 = new(100);
    MyClass obj2 = new(200,obj1);
    MyClass c = obj2.clone();        // call clone
  end
endmodule

//OUTPUT
# Data = 100

# Data = 200
# Nested Data = 100 

# Data = 200
# Data = 100
#  Cloned Data         100
#  Cloned Nested  Data         100
#  Cloned Data         200
