// Non- Blocking Events
module non_blocking_event;
  event BJT;
  initial begin 
    $display($time,"\t triggering the event");
    ->>BJT; ////using non blocking triggering  so even though when waiting of an event and triggering of an event takes place at same time 
    //so @ does not blocks the process as non blocking triggering works in non blocking region where @ works in active region so @ unblock the process below 
  end 
  initial begin
    $display($time,"\t waiting for the event using wait");
    wait(BJT.triggered);
    $display($time,"\t event BJT is triggered using wait");
  end
  initial begin
    $display($time,"\t waiting for the event using @");
    @(BJT.triggered); 
    $display($time,"\t event BJT is triggered using @");
  end
endmodule  

//OUTPUT
                   0	 triggering the event
                   0	 waiting for the event using wait
                   0	 waiting for the event using @
                   0	 event BJT is triggered using wait
                   0	 event BJT is triggered using @
