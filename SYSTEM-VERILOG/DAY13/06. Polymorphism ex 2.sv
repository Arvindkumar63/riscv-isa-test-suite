//Polymorphism ex 2
class Shape ;
  virtual function real area;
    return 0;
  endfunction
endclass

class Circle extends Shape;
  real radius;
  function new(real r);
    radius = r;
  endfunction
  function real area();
    return 3.14*radius*radius;
  endfunction
endclass

class Rectangle extends Shape;
  real width,height;
  function new(real w, h);
    width = w;
    height = h;
  endfunction
  function real area();
    return width*height;
  endfunction
endclass

module poly;
  Shape s;
  Circle c;
  Rectangle r;
  initial begin
    c = new(5.0);
    r = new(3.0,4.0);
    
    s = c;
    $display("Area of Circle : %0f",s.area());
    
    s = r;
    $display("Area of Rectangle : %0f",s.area());
  end
endmodule

//OUTPUT
Area of Circle : 78.500000
Area of Rectangle : 12.000000
