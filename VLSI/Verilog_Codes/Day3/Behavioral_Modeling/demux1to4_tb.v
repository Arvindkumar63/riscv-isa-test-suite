module demux1to4_tb;
  reg din;
  reg [1:0]s;
  wire [3:0]y;

  demux1to4 uut(
  .din(din), 
  .s(s),  
  .y(y));

  initial begin
    $dumpfile("demux1to4.vcd");
    $dumpvars(0, demux1to4_tb);
    $display("TIME | din s1 s0 | y0 y1 y2 y3");
    $display("--------------------------------");
    $monitor("%4t |  %b   %b  %b |  %b  %b  %b  %b", $time, din, s[1], s[0], y[0], y[1], y[2], y[3]);

    din=1; s[1]=0; s[0]=0; #10;
    din=1; s[1]=0; s[0]=1; #10;
    din=1; s[1]=1; s[0]=0; #10;
    din=1; s[1]=1; s[0]=1; #10;
    $finish;
  end

endmodule

