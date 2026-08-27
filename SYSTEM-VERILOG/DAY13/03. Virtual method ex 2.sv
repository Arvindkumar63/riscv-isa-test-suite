//Virtual method ex 2
class packet;
  string a;
  int b;
  function new();
    a="Team";
    b=4;
  endfunction
  virtual function void display();
    $display("a=%s",a);
    $display("b=%0d",b);
  endfunction
endclass

class child1 extends packet;
  string c;
  int d;
  function new();
    c="BJT";
    d=8;
  endfunction
  function void display();
    super.display();
    $display("c = %s",c);
    $display("d = %0d",d);
  endfunction
endclass

class child2 extends packet;
  string e;
  function new();
    e="Manipal";
  endfunction 
  function void display();
    $display("e = %s",e);
  endfunction
endclass

  packet p1,p2;
  child1 c1;
  child2 c2;
module virt_fun;
  initial begin
    c1=new();
    c2=new();
    p1=c1;
    p2=new c2;
    $display("contents of p1");
    p1.display();
    $display("contents of p2");
    p2.display();
  end
endmodule

// OUTPUT
// contents of p1
// a=Team
// b=4
// c = BJT
// d = 8
// contents of p2
// e = Manipal
