`timescale 1ns/1ps

module time_realtime;
  reg clk;

  initial begin
    clk = 0;
    repeat(5) begin
      #10.5 clk = ~clk;
      $display("TIME = %0t, REALTIME = %0.3f, CLK=%b", $time, $realtime,clk);
    end
    $finish;
  end
endmodule

