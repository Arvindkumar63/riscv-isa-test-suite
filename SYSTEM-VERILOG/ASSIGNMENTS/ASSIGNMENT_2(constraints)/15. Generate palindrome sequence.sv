// Generate palindrome sequence
class cons_15;
  rand bit[2:0] val[];
  rand int n;
  
  constraint c1{val.size == 10; n == val.size();}
  
  constraint c15{ foreach(val[i])
    if (i < n/2)
      val[i] == val[n-i-1];}
endclass
module constraint_15;
  cons_15 c1 = new();
  initial begin
    void'(c1.randomize());
    $display("val = %0p", c1.val);
  end
endmodule

//OUTPUT
val = 4 6 3 0 0 0 0 3 6 4
