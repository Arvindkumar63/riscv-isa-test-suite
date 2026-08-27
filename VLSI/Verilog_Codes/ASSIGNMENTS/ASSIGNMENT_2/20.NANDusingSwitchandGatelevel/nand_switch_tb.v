module nand_switch_tb;
  reg a, b;
  wire out;

  nand_switch uut (
    .a(a),
    .b(b),
    .out(out)
  );

  initial begin
    $dumpfile("nand_wave.vcd");
    $dumpvars(0, nand_switch_tb);

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

