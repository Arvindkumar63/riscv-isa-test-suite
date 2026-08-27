module Full_Subtractor_tb;
  reg a, b, c;
  wire dif , bor;

  Full_Subtractor uut(
  .a(a),
  .b(b),
  .c(c),
  .dif(dif),
  .bor(bor));

  initial begin
    $dumpfile("FS_wave.vcd");
    $dumpvars(0, Full_Subtractor_tb);
    $display("TIME | A | B | C | DIFFERENCE | BORROW");
    $display("---------------------------------------");
    $monitor("%4t | %b | %b | %b |    %b    |    %b", $time, a, b, c, dif , bor);

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
