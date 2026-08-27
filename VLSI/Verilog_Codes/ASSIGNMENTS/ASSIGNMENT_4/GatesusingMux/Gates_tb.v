module gates_tb;
  reg a,b;
  wire and_y, or_y, nand_y, nor_y, xor_y, xnor_y;

  gates g1(.a(a), .b(b), .and_y(and_y), .or_y(or_y), .nand_y(nand_y), .nor_y(nor_y), .xor_y(xor_y), .xnor_y(xnor_y));

  initial begin 
    $dumpfile("gates.vcd");
    $dumpvars(0, gates_tb);
    $monitor("TIME=%4t a=%b b=%b AND=%b OR=%b NAND=%b NOR=%b XOR=%b XNOR=%b", $time, a, b,and_y, or_y, nand_y, nor_y, xor_y, xnor_y);

    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;
    $finish;
  end
endmodule
