// Implication Operator
class class_0;  
  rand bit [2:0] value1;  
  rand bit [3:0] value2;  

  constraint c_mode { (value1 inside {[1:5]}) -> (value2 < 8); } 
  //  if the value1 lies between the range of 1 and 5 then the value2 is always less than 8. If the value1 does not lie between the range of 1 and 5 then the value2 is anything (not consider the constraint)
endclass  

module top;  
  initial begin  
    class_0 c = new();  

    $display("----- Output for implication constraint -----");  
    $display("-------------------------------------------");  

    for (int i = 0; i < 10; i++) begin  
      void'(c.randomize());  
      $display("Iteration %0d -----> value1 = %0d , value2 = %0d", i, c.value1, c.value2);  
    end  
  end  
endmodule  


//OUTPUT
----- Output for implication constraint -----
-------------------------------------------
Iteration 0 -----> value1 = 4 , value2 = 0
Iteration 1 -----> value1 = 0 , value2 = 10
Iteration 2 -----> value1 = 4 , value2 = 7
Iteration 3 -----> value1 = 7 , value2 = 6
Iteration 4 -----> value1 = 6 , value2 = 5
Iteration 5 -----> value1 = 6 , value2 = 13
Iteration 6 -----> value1 = 1 , value2 = 5
Iteration 7 -----> value1 = 7 , value2 = 12
Iteration 8 -----> value1 = 5 , value2 = 6
Iteration 9 -----> value1 = 6 , value2 = 10

