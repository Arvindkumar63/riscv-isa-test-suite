module Logic_gates_tb;
  reg a, b;
  wire and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out;

  Logic_gates uut(
    .a(a), .b(b),
    .and_out(and_out), .or_out(or_out), .not_out(not_out),
    .nand_out(nand_out), .nor_out(nor_out),
    .xor_out(xor_out), .xnor_out(xnor_out)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, Logic_gates_tb);
    $display("Time | a b | AND OR NOT NAND NOR XOR XNOR");
    $display("------------------------------------------");
    $monitor("%4t | %b %b |  %b   %b  %b    %b   %b   %b   %b",
             $time, a, b, and_out, or_out, not_out,
             nand_out, nor_out, xor_out, xnor_out);

    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end

endmodule

