// Bidirectional Constraint
class items;  
  rand bit [3:0] value1;  
  constraint addr_mode1 { value1 > 5; value1 < 12; }  
  constraint addr_mode2 { value1 > 6; }  
endclass  

module constraint_top;  
  initial begin  
    items item = new();  

    $display("----- Output for bidirectional constraint -----");  
    $display("----- Constraint 1 & 2 limits the value to 7, 8, 9, 10, and 11 -----");  
    for (int i = 0; i < 10; i++) begin  
      void'(item.randomize());  
      $display(" Iteration %0d -----> value1 = %0d", i, item.value1);  
    end   
  end  
endmodule 

//OUTPUT
----- Output for bidirectional constraint -----
----- Constraint 1 & 2 limits the value to 7, 8, 9, 10, and 11 -----
 Iteration 0 -----> value1 = 8
 Iteration 1 -----> value1 = 9
 Iteration 2 -----> value1 = 11
 Iteration 3 -----> value1 = 11
 Iteration 4 -----> value1 = 7
 Iteration 5 -----> value1 = 11
 Iteration 6 -----> value1 = 8
 Iteration 7 -----> value1 = 9
 Iteration 8 -----> value1 = 9
 Iteration 9 -----> value1 = 7
