module Half_Subtractor_tb;
  reg a,b;
  wire dif, bor;

  Half_Subtractor uut(
  .a(a),
  .b(b),
  .dif(dif),
  .bor(bor));

  initial begin
    $dumpfile("HS_wave.vcd");
    $dumpvars(0, Half_Subtractor_tb);
    $display("TIME | A | B | DIFFERENCE | BORROW");
    $display("-----------------------------------");
    $monitor("%4t | %b | %b |        %b  |    %b", $time, a, b, dif, bor);

    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end

endmodule
