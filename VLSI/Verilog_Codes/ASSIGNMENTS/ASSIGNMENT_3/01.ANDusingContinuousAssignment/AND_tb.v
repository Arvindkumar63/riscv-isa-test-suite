module and_gate_tb;
  reg a, b;
  wire out;

  and_gate uut (
    .a(a),
    .b(b),
    .out(out)
  );

  initial begin
    $dumpfile("and_g_wave.vcd");
    $dumpvars(0, and_gate_tb);

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

