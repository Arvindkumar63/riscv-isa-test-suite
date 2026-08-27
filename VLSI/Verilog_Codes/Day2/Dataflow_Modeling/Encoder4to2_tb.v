module Encoder4to2_tb;
  reg [3:0] d;
  wire[1:0] y;

  Encoder4to2 uut(d, y);

  initial begin
    $dumpfile("Encoder4to2.vcd");
    $dumpvars(0, Encoder4to2_tb);
    $display("TIME | D0 D1 D2 D3 | Y1 Y0");
    $display("---------------------------");
    $monitor("%4t |  %b  %b  %b  %b |  %b  %b", $time, d[0], d[1], d[2], d[3], y[1], y[0]);

    d[0]=1; d[1]=0; d[2]=0; d[3]=0; #10;
    d[0]=0; d[1]=1; d[2]=0; d[3]=0; #10;
    d[0]=0; d[1]=0; d[2]=1; d[3]=0; #10;
    d[0]=0; d[1]=0; d[2]=0; d[3]=1; #10;
    d[0]=1; d[1]=1; d[2]=0; d[3]=0; #10;
    $finish;
  end

endmodule

