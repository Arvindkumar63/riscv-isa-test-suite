// wait_order()
module waitorder_ex;
  event e1; 
  event e2; 
  event e3; 
  
  initial begin
    fork
      //process-1, triggers the event e1
      begin
        #2;
        $display($time,"\tTriggering The Event e1");
        ->e1;
      end
      //process-2, triggers the event e2
      begin
        #4;
        //$display($time,"\tTriggering The Event e2");
        #4;
        $display($time,"\tTriggering The Event e2");
        ->e2;
      end
      //process-3, triggers the event e3
      begin
        #6;
        $display($time,"\tTriggering The Event e3");
        ->e3;
      end
      //process-4, wait for the events to trigger in order of e1,e3 and e2
      begin
        $display($time,"\tWaiting for the Event's to trigger");
        wait_order(e1,e3,e2)
        $display($time,"\tEvent's triggered Inorder");
        else
          $display($time,"\tEvent's triggered Out-Of-Order");
      end
    join
  end
endmodule  
//OUTPUT
0	Waiting for the Event's to trigger
2	Triggering The Event e1
6	Triggering The Event 
8	Triggering The Event e2
8	Event's triggered Inorder
