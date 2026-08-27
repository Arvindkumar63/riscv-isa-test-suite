// Polymorphism
class parent_class;
  int a;
  int b;
  virtual function void display();
    a = 1;
    b = 2;
    $display("This is parent class");
    $display("a = %0d | b = %0d ",a,b);
  endfunction
endclass

class child1 extends parent_class;
  int c,d,e;
  function void display();
    a = 3;
    c = 4;
    d = 5;
    e = a+c+d;
    $display("This is child1 class");
    $display("a = %0d, c = %0d, d = %0d | e = %0d",a,c,d,e);
  endfunction
endclass


module polymorph;
  parent_class p1[1:0];
  child1 c1;
  
  initial begin
    c1 = new();
    p1[0] = c1; // child handle assigned to parent handle
    p1[1] = new();
    p1[0].display(); // access the child method
    p1[1].display(); // access the parent method
  end
endmodule
//Here the parent class handle is taking many forms to access child class methods which indeed called poly which is many forms in the polymorphism

//OUTPUT
This is child1 class
a = 3, c = 4, d = 5 | e = 12
This is parent class
a = 1 | b = 2 
