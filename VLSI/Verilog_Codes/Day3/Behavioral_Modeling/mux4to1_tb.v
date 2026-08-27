module mux4to1_tb;
  reg [3:0]d;
  reg [1:0]s;
  wire y;

  mux4to1 uut(
  .d(d),
  .s(s),
  .y(y));

  initial begin
    $dumpfile("Mux4to1.vcd");
    $dumpvars(0, mux4to1_tb);
    $display("TIME | D0 D1 D2 D3 s1 s0 | y");
    $display("----------------------------");
    $monitor("%4t |  %b  %b  %b  %b  %b  %b | %b", $time, d[0], d[1], d[2], d[3], s[1], s[0], y);

     d=4'b0001; s=2'b00; #10;
     d=4'b0010; s=2'b01; #10;
     d=4'b0100; s=2'b10; #10;
     d=4'b1000; s=2'b11; #10;
    $finish;
  end

endmodule

