// Write a code to Generate Armstrong number.

class armstrong_check;
  rand int unsigned num;
  static int valid_nums[$];
  
  constraint c1 { num inside { valid_nums }; }

  static function void build_list();
    for (int n = 1; n <= 99999; n++) begin
      if (n == arm_func(n))
        valid_nums.push_back(n);
    end
  endfunction
  

  static function int arm_func(int n);
    int temp, digit, count, sum;
    temp = n;
    
    count = (n == 0) ? 1 : 0;

    while (temp > 0) begin
      temp /= 10;
      count++;
    end

    temp = n;
    sum = 0;
    while (temp > 0) begin
      digit = temp % 10;
      sum += digit ** count;
      temp /= 10;
    end

    return sum;
  endfunction
  
  function void pre_randomize();
    build_list();
  endfunction
endclass


module tb;
  armstrong_check ac;

  initial begin
    ac = new();
    repeat (5) begin
      ac.randomize();
      $display("Armstrong = %0d", ac.num);
    end
  end
endmodule



// OUTPUT
# KERNEL: Armstrong = 153
# KERNEL: Armstrong = 93084
# KERNEL: Armstrong = 2
# KERNEL: Armstrong = 8
# KERNEL: Armstrong = 9
