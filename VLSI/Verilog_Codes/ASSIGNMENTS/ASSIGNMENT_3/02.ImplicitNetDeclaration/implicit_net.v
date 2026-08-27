module implicit_net;
  reg a,b;
  wire out = a|b;
  initial begin

    $display("Time | A B | OUT");
    $display("----------------");
    $monitor("%4t | %b %b | %b", $time, a, b, out);

    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end
endmodule
