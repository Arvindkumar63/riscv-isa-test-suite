// Break and continue 
module break_continue_example;
  int array[10];
  
  initial begin
    for (int i = 0; i < $size(array); i++) begin
      array[i] = 2*i;
    end
    $display("----------BREAK AT 6--------------");
    // Break keyword
    for (int i = 0; i < $size(array); i++) begin
      if(i == 6) break; //Terminate the loop
      $display("array[%0d] = %0d", i, array[i]);
    end
    
    $display("-----------CONTINUE AT 6-------------");
    // Continue keyword
    for (int i = 0; i < $size(array); i++) begin
      if(i == 6) continue; //skip the iteration only
      $display("array[%0d] = %0d", i, array[i]);
    end
  end
endmodule
