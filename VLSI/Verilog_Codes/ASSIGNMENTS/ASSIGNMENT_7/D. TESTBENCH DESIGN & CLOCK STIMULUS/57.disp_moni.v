module display_monitor;
  reg a, b;
  wire y;

  assign y = a&b;

  initial begin
    $monitor("MONITOR: t=%0t a=%b b=%b y=%b", $time, a, b, y);
    a = 0; b = 0; #5;
    $display("DISPLAY: t=%0t a=%b b=%b y=%b", $time, a, b, y);
    a = 1; b = 0; #5;
    a = 1; b = 1; #5;
    $finish;
  end
endmodule

