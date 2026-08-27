// Solve before constraint
class without_solve_bef;
  rand bit value1;
  rand bit [3:0] value2;
  constraint val{ value1 == 1 -> value2 ==1;}
endclass

class with_solve_bef;
  rand bit v1;
  rand bit [3:0] v2;
  constraint valu{ v1 == 1 -> v2==1;
                 solve v1 before v2;
                 }
endclass

module solve_bef;
  initial begin
    without_solve_bef b1 = new();
    with_solve_bef b2 = new();
    
    for (int i=0 ; i<32; i++) begin
      b1.randomize();
      $display("Iteration: %0d     |     value1=%0d | value2 = %0d ", i,b1.value1,b1.value2);
    end
    
    $display("---------------------------------");
    
    for (int i=0 ; i<32; i++) begin
      b2.randomize();
      $display("Iteration: %0d     |     value1=%0d | value2 = %0d ", i,b2.v1,b2.v2);
    end
    
  end
endmodule
 

//without: both value1 and value2 constraints are taken into consideration i.e., probability of value1 to get 1 is 1/2 and for value2 to be 1 is 1/16,but for getting value1 as 1 & value2 as 1 is (1/2)*(1/16)=1/32.
//with: here the constraint solver first randomizes value1 and depending upon the value1, value2 is solved. so the probability of getting a value1 as 1 is 1/2.

//OUTPUT
# KERNEL: Iteration: 0     |     value1=0 | value2 = 1 
# KERNEL: Iteration: 1     |     value1=0 | value2 = 8 
# KERNEL: Iteration: 2     |     value1=0 | value2 = 3 
# KERNEL: Iteration: 3     |     value1=0 | value2 = 13 
# KERNEL: Iteration: 4     |     value1=0 | value2 = 12 
# KERNEL: Iteration: 5     |     value1=0 | value2 = 7 
# KERNEL: Iteration: 6     |     value1=0 | value2 = 8 
# KERNEL: Iteration: 7     |     value1=0 | value2 = 8 
# KERNEL: Iteration: 8     |     value1=0 | value2 = 10 
# KERNEL: Iteration: 9     |     value1=0 | value2 = 8 
# KERNEL: Iteration: 10     |     value1=0 | value2 = 9 
# KERNEL: Iteration: 11     |     value1=0 | value2 = 13 
# KERNEL: Iteration: 12     |     value1=0 | value2 = 2 
# KERNEL: Iteration: 13     |     value1=0 | value2 = 11 
# KERNEL: Iteration: 14     |     value1=0 | value2 = 1 
# KERNEL: Iteration: 15     |     value1=0 | value2 = 12 
# KERNEL: Iteration: 16     |     value1=0 | value2 = 14 
# KERNEL: Iteration: 17     |     value1=0 | value2 = 8 
# KERNEL: Iteration: 18     |     value1=0 | value2 = 15 
# KERNEL: Iteration: 19     |     value1=0 | value2 = 12 
# KERNEL: Iteration: 20     |     value1=0 | value2 = 14 
# KERNEL: Iteration: 21     |     value1=0 | value2 = 1 
# KERNEL: Iteration: 22     |     value1=0 | value2 = 9 
# KERNEL: Iteration: 23     |     value1=0 | value2 = 15 
# KERNEL: Iteration: 24     |     value1=0 | value2 = 7 
# KERNEL: Iteration: 25     |     value1=0 | value2 = 1 
# KERNEL: Iteration: 26     |     value1=0 | value2 = 5 
# KERNEL: Iteration: 27     |     value1=0 | value2 = 15 
# KERNEL: Iteration: 28     |     value1=0 | value2 = 9 
# KERNEL: Iteration: 29     |     value1=0 | value2 = 10 
# KERNEL: Iteration: 30     |     value1=0 | value2 = 9 
# KERNEL: Iteration: 31     |     value1=0 | value2 = 14 
# KERNEL: Iteration: 32     |     value1=0 | value2 = 7 
# KERNEL: Iteration: 33     |     value1=0 | value2 = 15 
# KERNEL: Iteration: 34     |     value1=0 | value2 = 7 
# KERNEL: Iteration: 35     |     value1=0 | value2 = 11 
# KERNEL: Iteration: 36     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 37     |     value1=0 | value2 = 0 
# KERNEL: Iteration: 38     |     value1=0 | value2 = 14 
# KERNEL: Iteration: 39     |     value1=0 | value2 = 7 
# KERNEL: Iteration: 40     |     value1=0 | value2 = 14 
# KERNEL: Iteration: 41     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 42     |     value1=0 | value2 = 7 
# KERNEL: Iteration: 43     |     value1=0 | value2 = 12 
# KERNEL: Iteration: 44     |     value1=0 | value2 = 12 
# KERNEL: Iteration: 45     |     value1=0 | value2 = 7 
# KERNEL: Iteration: 46     |     value1=0 | value2 = 5 
# KERNEL: Iteration: 47     |     value1=0 | value2 = 3 
# KERNEL: Iteration: 48     |     value1=0 | value2 = 6 
# KERNEL: Iteration: 49     |     value1=0 | value2 = 4 
# KERNEL: Iteration: 50     |     value1=0 | value2 = 5 
# KERNEL: Iteration: 51     |     value1=0 | value2 = 6 
# KERNEL: Iteration: 52     |     value1=0 | value2 = 13 
# KERNEL: Iteration: 53     |     value1=0 | value2 = 15 
# KERNEL: Iteration: 54     |     value1=0 | value2 = 15 
# KERNEL: Iteration: 55     |     value1=0 | value2 = 0 
# KERNEL: Iteration: 56     |     value1=0 | value2 = 12 
# KERNEL: Iteration: 57     |     value1=0 | value2 = 2 
# KERNEL: Iteration: 58     |     value1=0 | value2 = 11 
# KERNEL: Iteration: 59     |     value1=0 | value2 = 9 
# KERNEL: Iteration: 60     |     value1=0 | value2 = 2 
# KERNEL: Iteration: 61     |     value1=0 | value2 = 5 
# KERNEL: Iteration: 62     |     value1=0 | value2 = 5 
# KERNEL: Iteration: 63     |     value1=0 | value2 = 11 
# KERNEL: ---------------------------------
# KERNEL: Iteration: 0     |     value1=0 | value2 = 10 
# KERNEL: Iteration: 1     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 2     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 3     |     value1=0 | value2 = 2 
# KERNEL: Iteration: 4     |     value1=0 | value2 = 14 
# KERNEL: Iteration: 5     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 6     |     value1=0 | value2 = 8 
# KERNEL: Iteration: 7     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 8     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 9     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 10     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 11     |     value1=0 | value2 = 12 
# KERNEL: Iteration: 12     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 13     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 14     |     value1=0 | value2 = 5 
# KERNEL: Iteration: 15     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 16     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 17     |     value1=0 | value2 = 13 
# KERNEL: Iteration: 18     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 19     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 20     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 21     |     value1=0 | value2 = 7 
# KERNEL: Iteration: 22     |     value1=0 | value2 = 13 
# KERNEL: Iteration: 23     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 24     |     value1=0 | value2 = 12 
# KERNEL: Iteration: 25     |     value1=0 | value2 = 9 
# KERNEL: Iteration: 26     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 27     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 28     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 29     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 30     |     value1=1 | value2 = 1 
# KERNEL: Iteration: 31     |     value1=1 | value2 = 1 
