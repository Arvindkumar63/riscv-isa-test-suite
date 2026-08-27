//Testbench
`include "test.sv"
`include "interface.sv"
module tb;
  inter inf();
  test tst(inf);
  half_adder ha(.a(inf.a), .b(inf.b), .sum(inf.sum), .carry(inf.carry));
endmodule
