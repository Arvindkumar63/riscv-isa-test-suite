// post-randomize:  void function type that can be overridable runs after the randomization is performed.(only enter when the randomization is successful)

class generator;
  rand bit [3:0] value ;
  int check;
  constraint exp{ value > 5;}
  
  function void pre_randomize();
    $display("---------------In pre-randomize--------------");
    check = 0;
  endfunction
  
  function void post_randomize();
    $display("---------------In post-randomize--------------");
    check = 1;
  endfunction
endclass

module post_random;
  generator gen ;
  int check;
  initial begin
    gen = new();
    
    
    $display("---------- Calling Randomize-----------");  
    check = gen.randomize();  
    $display("Iteration: 1 -----> value: %0d ", gen.value);  
    if (check == 1)  
      $display("Randomization is performed");  
    else  
      $display("Randomization is not performed");  

   
    $display("------------Calling Randomize------------");  
    check = gen.randomize() with { value < 5; };  
    $display("Iteration: 2 -----> value: %0d ", gen.value);  
    if (check == 1)  
      $display("Randomization is performed");  
    else  
      $display("Randomization is not performed"); 
    
    $display("------------Calling Randomize------------");  
    check = gen.randomize() with { value  == 6; };  
    $display("Iteration: 3 -----> value: %0d ", gen.value);  
    if (check == 1)  
      $display("Randomization is performed");  
    else  
      $display("Randomization is not performed");
  end  
endmodule

//OUTPUT
# KERNEL: ---------- Calling Randomize-----------
# KERNEL: ---------------In pre-randomize--------------
# KERNEL: ---------------In post-randomize--------------
# KERNEL: Iteration: 1 -----> value: 9 
# KERNEL: Randomization is performed
# KERNEL: ------------Calling Randomize------------
# KERNEL: ---------------In pre-randomize--------------
# RCKERNEL: Warning: RC_0024 testbench.sv(36): Randomization failed. The condition of randomize call cannot be satisfied.
# RCKERNEL: Info: RC_0109 testbench.sv(36): ... after reduction gen.value to 3'(gen.value)
# RCKERNEL: Info: RC_0103 testbench.sv(36): ... the following condition cannot be met: (5<gen.value)&&(gen.value<5)
# RCKERNEL: Info: RC_1007 testbench.sv(3): ... see class 'generator' declaration.
# KERNEL: Iteration: 2 -----> value: 9 
# KERNEL: Randomization is not performed
# KERNEL: ------------Calling Randomize------------
# KERNEL: ---------------In pre-randomize--------------
# KERNEL: ---------------In post-randomize--------------
# KERNEL: Iteration: 3 -----> value: 6 
# KERNEL: Randomization is performed
