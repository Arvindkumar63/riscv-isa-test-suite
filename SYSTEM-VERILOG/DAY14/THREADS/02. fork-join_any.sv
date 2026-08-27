// Fork...Join_any
module fork_join_any;
  initial begin
    $display("----------------------------------------------");
    
    fork
      //----------------------------------
      //Process -1
      //----------------------------------
      begin
        $display($time,"\t Process-1 Started");
        #5;
        $display($time,"\t Process-1 Finished");
      end
      //----------------------------------
      //Process -2
      //----------------------------------
      begin
        $display($time,"\t Process-2 Started");
        #20;
        $display($time,"\t Process-2 Finished");
      end
    join_any
    
    $display($time, "\t Outside Fork-Join_any");
    $display("----------------------------------------------");
  end
endmodule

//OUTPUT
----------------------------------------------
                   0	 Process-1 Started
                   0	 Process-2 Started
                   5	 Process-1 Finished
                   5	 Outside Fork-Join_any
----------------------------------------------
                  20	 Process-2 Finished
