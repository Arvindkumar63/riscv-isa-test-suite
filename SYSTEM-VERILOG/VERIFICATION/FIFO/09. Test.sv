`include "Environment.sv"
program test #(parameter Width, Depth)(intf vif);
  environment  #(Width, Depth)envi;
  initial begin
    envi = new(vif);
    envi.envi();
  end
endprogram
