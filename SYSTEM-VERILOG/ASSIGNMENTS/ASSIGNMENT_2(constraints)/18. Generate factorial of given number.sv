//constraint to generate the factorial of a given number.
class cons_18;
  rand int val;
  
  constraint c18{ 
    val inside {[1:10]};
  }
  
  function void post_randomize();
    $write("%0d ->",val);
    val = fact(val);
  endfunction
  
  function automatic int fact(int n);
    if(n<2)
      return 1;
    else 
      return n*fact(n-1);
  endfunction
endclass

module constraint_18;
  cons_18 c1 = new();
  initial begin
    repeat(10) begin
      c1.randomize();
      $display(" %0d" , c1.val);
    end
  end
endmodule


//OUTPUT
3 -> 6
10 -> 3628800
7 -> 5040
2 -> 2
9 -> 362880
7 -> 5040
1 -> 1
9 -> 362880
9 -> 362880
3 -> 6
