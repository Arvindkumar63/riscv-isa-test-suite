module Demux_tb;
  reg din, s0, s1;
  wire y0, y1, y2, y3;

  Demux uut(
  .din(din), 
  .s0(s0), 
  .s1(s1), 
  .y0(y0), 
  .y1(y1), 
  .y2(y2), 
  .y3(y3));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Demux_tb);
    $display("TIME | din s1 s0 | y0 y1 y2 y3");
    $display("--------------------------------");
    $monitor("%4t |  %b   %b  %b |  %b  %b  %b  %b", $time, din, s1, s0, y0, y1, y2, y3);

    din=1; s1=0; s0=0; #10;
    din=1; s1=0; s0=1; #10;
    din=1; s1=1; s0=0; #10;
    din=1; s1=1; s0=1; #10;
    $finish;
  end

endmodule

