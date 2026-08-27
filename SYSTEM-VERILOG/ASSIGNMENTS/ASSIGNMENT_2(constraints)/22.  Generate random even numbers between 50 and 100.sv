// Write a constraint to generate random even numbers between 50 and 100.
class cons_22;
  rand int num;
  
  constraint c1{ 
    num inside {[50:100]};
  }
  constraint c2{
    num%2 == 0;
  }
endclass

module const_numb;
  cons_22 c;
  initial begin
    c = new();
    repeat(5) begin
      c.randomize();
      $display("Number = %0d",c.num);
    end
  end
endmodule

//OUTPUT
# KERNEL: Number = 84
# KERNEL: Number = 84
# KERNEL: Number = 64
# KERNEL: Number = 56
# KERNEL: Number = 80
