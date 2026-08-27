//Generator
class generator;
  transaction trans;
  mailbox gentodrv;
  event trigger;
  
  function new(mailbox gentodrv);
    this.trans = trans;
    this.gentodrv = gentodrv;
  endfunction
  
  task gen();
    trans = new();
    repeat(20) begin
      trans.randomize();
      trans.disp("GENERATOR");
      gentodrv.put(trans);
      @ trigger;
    end
  endtask
endclass
  
