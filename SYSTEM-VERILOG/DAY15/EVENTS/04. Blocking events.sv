// Blocking Events
module blocking_event;
  event BJT;
  initial begin 
    $display($time,"\t triggering the event");
    ->BJT;
  end 
  initial begin
    $display($time,"\t waiting for the event using wait");
    wait(BJT.triggered);
    $display($time,"\t event BJT is triggered using wait"); //  we can use wait(BJT.triggered) to detect the triggering
  end
  initial begin
    $display($time,"\t waiting for the event using @");
    @(BJT.triggered);
    $display($time,"\t event BJT is triggered using @"); //AS blocking triggering and @ both work in active region 
    //so when triggering and waiting of an event takes place at same time at 0ns by using @ operator it block the statement
  end
endmodule  

//OUTPUT
                   0	 triggering the event
                   0	 waiting for the event using wait
                   0	 event BJT is triggered using wait
                   0	 waiting for the event using @
