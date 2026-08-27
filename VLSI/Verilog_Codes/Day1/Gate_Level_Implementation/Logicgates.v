module Logic_gates(
  input a, b,
  output and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out);

  // Built-in gate primitives
  and  g1(and_out, a, b);    // AND gate
  or   g2(or_out, a, b);     // OR gate
  not  g3(not_out, a);       // NOT gate
  nand g4(nand_out, a, b);   // NAND gate
  nor  g5(nor_out, a, b);    // NOR gate
  xor  g6(xor_out, a, b);    // XOR gate
  xnor g7(xnor_out, a, b);   // XNOR gate

endmodule

