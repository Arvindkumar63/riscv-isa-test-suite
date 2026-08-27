// Generate sequence 1122334455
class cons_14;
  rand int a[10];
  constraint c14{ foreach(a[i])
    a [i] == (i+2)/2;}
endclass

module constraint_14;
  cons_14 c1 = new();
  initial begin
    c1.randomize();
    $display("a = %0p", c1.a);
  end
endmodule



//OUTPUT
a = '{1, 1, 2, 2, 3, 3, 4, 4, 5, 5}
