// Write a code to generate a random floating-point number between 1.35 and 2.57.

class rand_real;
  rand int val;
  real value;
  
  constraint c1 { val inside {[13500:25700]} ;}
  
  function void post_randomize();
    value = val / 10000.0;
  endfunction
  
endclass
  
module tb;
  rand_real rr;
  initial begin
    rr = new();
    repeat(10) begin
      rr.randomize();
      $display(" Random real = %0f ", rr.value);
    end
  end
endmodule

//OUTPUT
# KERNEL:  Random real = 1.553700 
# KERNEL:  Random real = 2.472500 
# KERNEL:  Random real = 2.363500 
# KERNEL:  Random real = 2.110600 
# KERNEL:  Random real = 1.792800 
# KERNEL:  Random real = 2.333400 
# KERNEL:  Random real = 2.051500 
# KERNEL:  Random real = 1.658600 
# KERNEL:  Random real = 1.907900 
# KERNEL:  Random real = 1.600800 
