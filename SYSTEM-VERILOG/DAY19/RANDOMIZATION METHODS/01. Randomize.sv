// Randomize: randomize is a virtual function of int type returns 1 on successful completion else 0
class gene;
  rand bit [2:0] value;  
  constraint cons { value == 5; }  
endclass  

module randomization();  
  gene gen;  
  initial begin 
    gen = new();
    $display("----------Calling Randomize-----------");  

    if (gen.randomize())  
      $display("value: %0d Randomization successful", gen.value);  
    else  
      $display("value: %0d Randomization Failed", gen.value);  

    $display("----------Calling Randomize--------------");  

    if (gen.randomize() with { value == 2; })  
      $display("value: %0d Randomization successful", gen.value);  
    else  
      $display("value: %0d Randomization Failed", gen.value);  
  end  

endmodule  

//OUTPUT
# KERNEL: ----------Calling Randomize-----------
# KERNEL: value: 5 Randomization successful
# KERNEL: ----------Calling Randomize--------------
# RCKERNEL: Warning: RC_0024 testbench.sv(20): Randomization failed. The condition of randomize call cannot be satisfied.
# RCKERNEL: Info: RC_0109 testbench.sv(20): ... after reduction gen.value to 5
# RCKERNEL: Info: RC_0103 testbench.sv(20): ... the following condition cannot be met: (3'(5)==2)
# RCKERNEL: Info: RC_1007 testbench.sv(2): ... see class 'gene' declaration.
# KERNEL: value: 5 Randomization Failed
