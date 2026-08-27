// Pre Randomize :This is a void function type that can be overridable called before the actual randomization performs.

class generator;  
  rand bit [4:0] value;  
  int i;  
  
  function void pre_randomize();  
    if (i % 2 == 0) begin  
      rand_mode(0);  
      $display("stopping randomization");  
    end  
    else begin
      rand_mode(1);
      $display("enabling randomization");
    end
    
    i++;  
  endfunction 
  
endclass  

module pre_random;  
  generator gen; 
  initial begin  
    gen = new();
    for (int i = 1; i < 5; i++) begin  
      $display("------------ Calling Randomize--------------");  
      void'(gen.randomize());  
      $display("Iteration: %0d -----> value: %0d ", i, gen.value);  
    end  
  end  
endmodule  


//OUTPUT
# KERNEL: ------------ Calling Randomize--------------
# KERNEL: stopping randomization
# KERNEL: Iteration: 1 -----> value: 0 
# KERNEL: ------------ Calling Randomize--------------
# KERNEL: enabling randomization
# KERNEL: Iteration: 2 -----> value: 25 
# KERNEL: ------------ Calling Randomize--------------
# KERNEL: stopping randomization
# KERNEL: Iteration: 3 -----> value: 25 
# KERNEL: ------------ Calling Randomize--------------
# KERNEL: enabling randomization
# KERNEL: Iteration: 4 -----> value: 19 
# KERNEL: ------------ Calling Randomize--------------
# KERNEL: enabling randomization
# KERNEL: Iteration: 6 -----> value: 29 
# KERNEL: ------------ Calling Randomize--------------
# KERNEL: stopping randomization
# KERNEL: Iteration: 7 -----> value: 29 
# KERNEL: ------------ Calling Randomize--------------
# KERNEL: enabling randomization
# KERNEL: Iteration: 8 -----> value: 10 
# KERNEL: ------------ Calling Randomize--------------
# KERNEL: stopping randomization
# KERNEL: Iteration: 9 -----> value: 10 
