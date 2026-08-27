// Write a constraint to generate palindrome numbers.
class palind_numb;
  rand int t1;
  randc bit t2;
  rand int num;
  
  constraint c1{
    t1 inside {[0:50]};
  }
  constraint c2{
    num == rev_func(t1,t2);
  }
  
  function int rev_func(int n,t2);
    int tmp = 0;
    int l1;
    int p1 = n;
    
    if(t2)
      n = n/10;
    
    while(n>0) begin
      l1 = n%10;
      tmp = tmp*10 + l1;
      n = n/10;
      p1 = p1*10;
    end
    
    tmp = p1 + tmp;
    return tmp;
    
  endfunction
    
endclass

module palin;
  palind_numb p1;
  initial begin
    p1 = new();
    repeat(5) begin
      p1.randomize();
      $display("Number = %0d",p1.num);
    end
  end
endmodule

//OUTPUT
# KERNEL: Number = 363
# KERNEL: Number = 2992
# KERNEL: Number = 262
# KERNEL: Number = 2552
# KERNEL: Number = 454
