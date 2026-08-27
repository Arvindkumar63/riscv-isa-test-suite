//wait fork example
//--------------With wait fork----------------------------
module wait_fork;
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
    wait fork; // wait to execute the child processes
    $finish; // Terminate the simulation after complete the child processes execution
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

