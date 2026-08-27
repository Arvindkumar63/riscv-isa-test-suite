//Environment
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;
  transaction tr;
  generator gen;
  driver driv;
  monitor moni;
  scoreboard scor;
  
  mailbox gen_to_driv;
  mailbox moni_to_scor;
  virtual inter inf;
  
  function new(virtual inter inf);
    this.inf = inf;
    tr = new();
    gen_to_driv = new();
    moni_to_scor = new();
    
    gen = new(gen_to_driv);
    driv = new(inf, gen_to_driv);
    moni = new(inf, moni_to_scor);
    scor = new(moni_to_scor);    
  endfunction
  
  task env();
    fork
      gen.gen();
      driv.driv();
      moni.moni();
      scor.scor();
    join
  endtask
endclass
