module decode_tb;
  reg [1:0]d;
  wire [3:0]y;

  decode uut(
  .d(d), .y(y) );

  initial begin
    $dumpfile("Decoder2t04.vcd");
    $dumpvars(0, decode_tb);
    $display("TIME | D1 D0 | Y3 Y2 Y1 Y0");
    $display("-------------------------");
    $monitor("%4t | %b %b | %b  %b  %b  %b", $time, d[1], d[0], y[3], y[2], y[1], y[0]);

    d =2'b00; #10;
    d =2'b01; #10;
    d =2'b10; #10;
    d =2'b11; #10;
    $finish;
  end

endmodule

