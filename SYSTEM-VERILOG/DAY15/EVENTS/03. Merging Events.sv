// Merging events
module merge_events;
  event a,b;
  initial begin
    fork
    #50 -> a; 
    #30 -> b;
    #20 a = b;
      begin 
        wait(a.triggered);
        $display("[%0t] event a is done",$time);
      end    
      begin 
        wait(b.triggered);
        $display("[%0t] event b is done ",$time);
      end
    join
  end
endmodule  

//OUTPUT
[30] event b is done 
[30] event a is done
