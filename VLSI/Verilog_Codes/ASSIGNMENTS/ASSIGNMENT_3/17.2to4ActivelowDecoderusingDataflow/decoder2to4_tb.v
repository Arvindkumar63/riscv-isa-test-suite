module decoder2to4_tb;
  reg a, b;
  wire d0, d1, d2, d3;

  decoder2to4 uut(
  .a(a), 
  .b(b),
  .d0(d0), 
  .d1(d1), 
  .d2(d2), 
  .d3(d3));

  initial begin
    $dumpfile("decoder2t04.vcd");
    $dumpvars(0, decoder2to4_tb);
    $display("TIME | A B | D0 D1 D2 D3");
    $display("-------------------------");
    $monitor("%4t | %b %b | %b  %b  %b  %b", $time, a, b, d0, d1, d2, d3);

    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end

endmodule

