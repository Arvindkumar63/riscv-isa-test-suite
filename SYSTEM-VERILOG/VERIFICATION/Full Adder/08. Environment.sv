//Environment
`include "Transaction.sv"
`include "Generator.sv"
`include "Driver.sv"
`include "Monitor.sv"
`include "Scoreboard.sv"

class environment;
  transaction tr;
  generator gen;
  driver drive;
  monitor moni;
  scoreboard score;
  
  mailbox gen_to_driv;
  mailbox moni_to_score;
  virtual inter inf;
  
  function new(virtual inter inf);
    this.inf = inf;
    tr = new();
    gen_to_driv = new();
    moni_to_score = new();
    gen = new(gen_to_driv);
    drive = new(inf,gen_to_driv);
    moni = new(inf,moni_to_score);
    score = new(moni_to_score);
  endfunction
  
  task env();
    fork
      gen.gen();
      drive.drive();
      moni.moni();
      score.score();
    join
  endtask
  
endclass
    
