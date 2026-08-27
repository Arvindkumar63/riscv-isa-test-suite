`include "environment.sv"

program test(fifo_intf inf);
  environment env;
  
  initial begin
    env=new(inf);
    env.envi();
  end
endprogram
