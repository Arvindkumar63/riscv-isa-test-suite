//fork-join combine ex
module fork_join_combine;
  initial begin
    $display($time,"------------------------------------------------");
    $display($time," starts fork...join ex");
    #10;
    $display($time," sequential after #10");
    $display($time,"------------------------------------------------");
    fork
      $display($time, " parallel start");
      #50 $display($time, " parallel after #50");
      #10 $display($time, " parallel after #10");
      begin
        #30 $display($time," sequential after #30");
        #10 $display($time," sequential after #10");
      end
    join
    #10 $display($time," After Fork Join");
    $display($time,"------------------------------------------------");
    fork
      #10$display($time, " parallel start fork-join_any after #10");
      #50 $display($time, " parallel after #50");
      #20 $display($time, " parallel after #20");
      begin
        #30 $display($time," sequential after #30");
        #10 $display($time," sequential after #10");
      end
    join_any
    #20 $display($time," After Fork Join_any");
    $display($time,"------------------------------------------------");
    fork
      #10$display($time, " parallel start fork-join_none after #10");
      #50 $display($time, " parallel after #50");
      #20 $display($time, " parallel after #20");
      begin
        #30 $display($time," sequential after #30");
        #10 $display($time," sequential after #10");
      end
    join_none
    #20 $display($time," After Fork Join_none");
    #50 $display($time,"------------------------------------------------");
  end
endmodule

//OUTPUT
                   0------------------------------------------------
                   0 starts fork...join ex
                  10 sequential after #10
                  10------------------------------------------------
                  10 parallel start
                  20 parallel after #10
                  40 sequential after #30
                  50 sequential after #10
                  60 parallel after #50
                  70 After Fork Join
                  70------------------------------------------------
                  80 parallel start fork-join_any after #10
                  90 parallel after #20
                 100 sequential after #30
                 100 After Fork Join_any
                 100------------------------------------------------
                 110 sequential after #10
                 110 parallel start fork-join_none after #10
                 120 parallel after #50
                 120 After Fork Join_none
                 120 parallel after #20
                 130 sequential after #30
                 140 sequential after #10
                 150 parallel after #50
                 170------------------------------------------------
