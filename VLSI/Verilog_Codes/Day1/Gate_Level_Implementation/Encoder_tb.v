module Encoder_tb;
  reg d0, d1, d2, d3;
  wire y1, y0;

  Encoder uut(.d0(d0), .d1(d1), .d2(d2), .d3(d3), .y1(y1), .y0(y0));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Encoder_tb);
    $display("TIME | D0 D1 D2 D3 | Y1 Y0");
    $display("---------------------------");
    $monitor("%4t |  %b  %b  %b  %b |  %b  %b", $time, d0, d1, d2, d3, y1, y0);

    d0=1; d1=0; d2=0; d3=0; #10;
    d0=0; d1=1; d2=0; d3=0; #10;
    d0=0; d1=0; d2=1; d3=0; #10;
    d0=0; d1=0; d2=0; d3=1; #10;
    $finish;
  end

endmodule

