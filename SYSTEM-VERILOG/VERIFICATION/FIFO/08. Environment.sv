//Environment
`include "transaction.sv"
`include "Generator.sv"
`include "Driver.sv"
`include "Monitor.sv"
`include "Scoreboard.sv"

class environment #(parameter Width, Depth );
  generator #(Width)gen;
  driver  #(Width, Depth)driv;
  monitor  #(Width, Depth)moni;
  scoreboard #(Width)scor;
  transaction #(Width)tr;
  
  mailbox gen_to_driv;
  mailbox moni_to_scor;
  
  virtual intf  #(Width, Depth) vif;
  event trigger;
  
  function new(virtual intf #(Width, Depth)vif);
    this.vif = vif;
    gen_to_driv = new();
    moni_to_scor = new();
    gen = new(gen_to_driv);
    driv = new(gen_to_driv, vif);
    moni = new(moni_to_scor, vif);
    scor = new(moni_to_scor);
    
    gen.trigger = this.trigger;
    scor.trigger = this.trigger;
  endfunction
  
  task envi();
    fork 
      gen.gen();
      driv.drv();
      moni.moni();
      scor.scor();
    join
  endtask
endclass
