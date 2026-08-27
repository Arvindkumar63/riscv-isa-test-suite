// static example 1
class base;
  static int i;
  static function static get();
    int a; // This also static bcoz its inside static method
    a++;
    i++;
    $display(a);
    $display(i);
  endfunction
endclass

base b1, b2;
module tb;
  initial begin
    b1.get();
    b1.get();// static properties have a single memory location for all handles and can access without creating the objects
    b2.get();
  end
endmodule

//OUTPUT
1
1
2
2
3
3
