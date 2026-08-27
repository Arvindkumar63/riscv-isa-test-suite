// Environment 
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"


class environment;
  
  transaction trans;
  generator gen;
  driver driv;
  monitor moni;
  scoreboard scor;
  
  mailbox gentodriv;
  mailbox monitoscor;
  virtual fifo_intf inf;
  
  function new(virtual fifo_intf inf);
    this.inf=inf;
    gentodriv =new();
    monitoscor=new();
    gen=new(gentodriv);
    driv=new(gentodriv,inf);
    moni=new(monitoscor,inf);
    scor=new(monitoscor);
  endfunction
  
  task envi();
    fork
      
      gen.gen();
      driv.driv();
      moni.moni();
      scor.scor();
    join
  endtask
endclass
