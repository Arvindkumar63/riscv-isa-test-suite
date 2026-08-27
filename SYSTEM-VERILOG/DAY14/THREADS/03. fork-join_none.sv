// Fork...Join_none
module fork_join_none;
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
    join_none
    
    $display($time, "\t Outside Fork-Join_none");
    $display("----------------------------------------------");
  end
endmodule

//OUTPUT
----------------------------------------------
                   0	 Outside Fork-Join_none
----------------------------------------------
                   0	 Process-1 Started
                   0	 Process-2 Started
                   5	 Process-1 Finished
                  20	 Process-2 Finished
