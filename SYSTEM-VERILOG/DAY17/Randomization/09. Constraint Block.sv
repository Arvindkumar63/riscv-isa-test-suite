//Constraint Block
class class_a;
  rand byte a;
  rand byte x;
  constraint cons_name1{a<6;
                        a>2;};
  extern constraint cons_name2;
endclass

constraint class_a:: cons_name2{x>50;}

module tb;
initial begin
  class_a pack = new();
  for (int i =0;i<=5;i++)begin
    void'(pack.randomize());
    $display ( "Iteration = %0d  Value of a = %0d Value of x = %0d  " , i,pack.a,pack.x);
    $display ("------------------------------------------------");
  end
end
endmodule

//OUTPUT
# KERNEL: Iteration = 0  Value of a = 3 Value of x = 102  
# KERNEL: ------------------------------------------------
# KERNEL: Iteration = 1  Value of a = 5 Value of x = 65  
# KERNEL: ------------------------------------------------
# KERNEL: Iteration = 2  Value of a = 4 Value of x = 69  
# KERNEL: ------------------------------------------------
# KERNEL: Iteration = 3  Value of a = 5 Value of x = 83  
# KERNEL: ------------------------------------------------
# KERNEL: Iteration = 4  Value of a = 5 Value of x = 51  
# KERNEL: ------------------------------------------------
# KERNEL: Iteration = 5  Value of a = 5 Value of x = 66  
# KERNEL: ------------------------------------------------
