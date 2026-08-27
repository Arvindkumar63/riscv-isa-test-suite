module write_display;
  reg [3:0] a, b;

  initial begin
    a = 4'd5; b = 4'd7;

    $display("Using $display:");
    $display("A=%d B=%d SUM=%d", a, b, a+b);
    $display("Next line starts here");

    $write("\n Using $write:");
    $write("A=%d B=%d SUM=%d", a, b, a+b);
    $write(" <- continues on same line");

    $finish;
  end
endmodule

