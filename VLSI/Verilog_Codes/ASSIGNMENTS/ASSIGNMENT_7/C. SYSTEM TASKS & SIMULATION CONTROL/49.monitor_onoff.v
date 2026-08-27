module monitor_control;
  reg clk, d;

  initial begin
    $monitor("TIME=%0t | clk=%b d=%b", $time, clk, d);
    clk = 0; d = 0;
    #5 d = 1;
    $monitoroff;  
    #5; d=1; clk=1;
    #5 d=1; clk=0;
    #5 d = 0; clk = 1;
    $monitoron;    
    #5 d = 1;
    #5 $finish;
  end
endmodule

