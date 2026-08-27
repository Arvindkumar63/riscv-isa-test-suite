// Fork...Join
module fork_join;
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
    join
    
    $display($time, "\t Outside Fork-Join");
    $display("----------------------------------------------");
  end
endmodule

//OUTPUT
----------------------------------------------
                   0	 Process-1 Started
                   0	 Process-2 Started
                   5	 Process-1 Finished
                  20	 Process-2 Finished
                  20	 Outside Fork-Join
----------------------------------------------
