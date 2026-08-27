//Environment
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  transaction trans;
  generator gen;
  driver drv;
  monitor moni;
  scoreboard scor;
  
  virtual inter inf;
  mailbox gentodrv;
  mailbox monitoscor;
  event triggering;
  
  function new(virtual inter inf);
    this.inf = inf;
    gentodrv = new();
    monitoscor = new();
    
    
    gen = new(gentodrv);
    drv = new(inf,gentodrv);
    moni = new(inf,monitoscor);
    scor = new(monitoscor);
    
    gen.trigger = this.triggering;
    scor.trigger = this.triggering;
  endfunction
  
  task envi();
    fork
      gen.gen();
      drv.drv();
      moni.moni();
      scor.scor();
    join
  endtask
endclass
