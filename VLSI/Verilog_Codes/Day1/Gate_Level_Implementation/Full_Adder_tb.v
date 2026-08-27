module Full_Adder_tb;
  reg a, b, c;
  wire s, c_out;

  Full_Adder uut(
  .a(a),
  .b(b),
  .c(c),
  .s(s),
  .c_out(c_out));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Full_Adder_tb);
    $display("TIME | A | B | C | SUM | CARRY");
    $display("----------------------------");
    $monitor("%4t | %b | %b | %b |  %b  |   %b", $time, a, b, c, s, c_out);

    a=0; b=0; c=0; #10;
    a=0; b=1; c=0; #10;
    a=1; b=0; c=0; #10;
    a=1; b=1; c=0; #10;
    a=0; b=0; c=1; #10;
    a=0; b=1; c=1; #10;
    a=1; b=0; c=1; #10;                                                                                                                                         a=1; b=1; c=1; #10;
    $finish;
  end

endmodule
