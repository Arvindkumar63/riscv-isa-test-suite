//wait and @ difference 
module wait_example;
  event e;
  
  initial begin
    $display($time, "\t triggering the event");
    ->e;
  end
  
  initial begin
    $display($time, "\t waiting for the event using wait");
    wait(e.triggered); //wait for the event to be triggered using wait //can detect
    $display($time, "\t event is triggered using wait");
  end

  initial begin
    $display($time, "\t waiting for the event using @");
    @(e.triggered); //wait for the event to be triggered using @ //cannot detect
    $display($time, "\t event is triggered using @");
  end
endmodule

//OUTPUT
                   0	 triggering the event
                   0	 waiting for the event using wait
                   0	 event is triggered using wait
                   0	 waiting for the event using @
