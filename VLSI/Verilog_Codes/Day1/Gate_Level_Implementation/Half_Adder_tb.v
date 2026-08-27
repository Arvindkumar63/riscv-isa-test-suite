module Half_Adder_tb;
  reg a,b;
  wire s, c_out;

  Half_Adder uut(
  .a(a),
  .b(b),
  .s(s),
  .c_out(c_out));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Half_Adder_tb);
    $display("TIME | A | B | SUM | CARRY");
    $display("----------------------------");
    $monitor("%4t | %b | %b |  %b  |   %b", $time, a, b, s, c_out);

    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end

endmodule
