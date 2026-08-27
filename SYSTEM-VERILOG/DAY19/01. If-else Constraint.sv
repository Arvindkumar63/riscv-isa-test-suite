// If-else Constraint
class basic;
  rand bit[3:0] value1;
  rand bit[3:0] value2;
  
  constraint c_var {
    if(value1 inside {[4:9]})
      value2 == 1;
    else
      value2 == 0;  }
endclass


module top;
  initial begin
    basic pkt = new();
    $display("----- Output for if-else constraint -----");  
    $display("If the value1 lies between 4 to 9, then value2 will be 1; otherwise, it will be 0.");  
    $display("--------------------------------------------------");
    
    for (int i=0; i<10; i++) begin
      void'(pkt.randomize());
      $display("Iteration:%0d  ------> value1 = %0d | value2 = %0d", i, pkt.value1, pkt.value2);
    end
  end
endmodule


//OUTPUT
----- Output for if-else constraint -----
If the value1 lies between 4 to 9, then value2 will be 1; otherwise, it will be 0.
--------------------------------------------------
Iteration:0  ------> value1 = 7 | value2 = 1
Iteration:1  ------> value1 = 8 | value2 = 1
Iteration:2  ------> value1 = 4 | value2 = 1
Iteration:3  ------> value1 = 7 | value2 = 1
Iteration:4  ------> value1 = 3 | value2 = 0
Iteration:5  ------> value1 = 5 | value2 = 1
Iteration:6  ------> value1 = 5 | value2 = 1
Iteration:7  ------> value1 = 15 | value2 = 0
Iteration:8  ------> value1 = 11 | value2 = 0
Iteration:9  ------> value1 = 5 | value2 = 1
