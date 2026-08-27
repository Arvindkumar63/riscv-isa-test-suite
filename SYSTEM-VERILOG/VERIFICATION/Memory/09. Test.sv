// Test
`include "environment.sv"
program test(inter inf);
  environment env;
  initial begin
    env = new(inf);
    env.envi();
  end
endprogram
