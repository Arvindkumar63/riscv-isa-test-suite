//Weighted distribution eg2
class myWorld;  
  rand bit [3:0] v1;  
  constraint m_var { v1 dist { [2:5] :/ 10, 10 :/ 40, 12 :/ 20 }; }  
endclass  

module top;  
  initial begin  
    myWorld world = new();  

    $display("----- Output for := operator -----");   
    for (int i = 0; i < 10; i++) begin  
      void'(world.randomize());  
      $display("Iteration: %0d -----> v1 = %0d", i, world.v1);  
    end  
  end  
endmodule  

//OUTPUT
----- Output for := operator -----
Iteration: 0 -----> v1 = 12
Iteration: 1 -----> v1 = 10
Iteration: 2 -----> v1 = 10
Iteration: 3 -----> v1 = 10
Iteration: 4 -----> v1 = 10
Iteration: 5 -----> v1 = 12
Iteration: 6 -----> v1 = 5
Iteration: 7 -----> v1 = 2
Iteration: 8 -----> v1 = 10
Iteration: 9 -----> v1 = 10
