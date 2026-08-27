//Testbench
`include "Interface.sv"
`include "Test.sv"
module tb;
  inter inf();
  test tst(inf);
  full_adder FA(.a(inf.a), .b(inf.b), .c(inf.c), .sum(inf.sum), .carry(inf.carry));
endmodule
