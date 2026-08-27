// static example 2
class base;
  int i;//non -static
  static function get();
    int a; // local variable also non-static // refresh to 0 every time function call
    a++;
    $display(a);
  endfunction
endclass

base b1, b2;
module tb;
  initial begin
    b1.get();//function call doesn't need object creation 
    b1.get();
    b2.get();
  end
endmodule

//OUTPUT
1
1
1
