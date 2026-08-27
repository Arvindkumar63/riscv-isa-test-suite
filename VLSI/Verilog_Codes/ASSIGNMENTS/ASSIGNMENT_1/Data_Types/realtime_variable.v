`timescale 1ns/1ps
module realtime_variable;
  realtime current_time;
  
  initial begin
    $monitor("TIME=%t, CURRENT_TIME=%f" ,$time,current_time);
    current_time=$realtime; #5.5;
    current_time=$realtime; #10.25;
    current_time=$realtime; #10.75;
    current_time=$realtime; #10.75;
    $finish;
  end

endmodule  
