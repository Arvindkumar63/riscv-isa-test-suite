module priority_select_tb;
  reg a, b, c;
  wire y;

  priority_select uut (.a(a), .b(b), .c(c), .y(y));

  initial begin
    $dumpfile("priority_select.vcd");
    $dumpvars(0,priority_select_tb);
    $monitor("T=%0t | a=%b b=%b c=%b | y=%b", $time, a, b, c, y);

    a=0; b=0; c=0; #5;
    a=1; b=0; c=0; #5;
    a=0; b=1; c=0; #5;
    a=1; b=1; c=0; #5;
    a=0; b=0; c=1; #5;
    a=1; b=0; c=1; #5;
    a=0; b=1; c=1; #5;
    a=1; b=1; c=1; #5;
    $finish;
  end
endmodule

