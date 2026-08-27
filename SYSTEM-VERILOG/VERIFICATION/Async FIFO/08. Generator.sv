//Generator
class generator;
  transaction trans;
  mailbox gentodriv;
  
  function new(mailbox gentodriv);
    this.gentodriv = gentodriv;
  endfunction
  
  
  task gen();
    repeat(50) begin
      trans = new();
      trans.randomize();
      gentodriv.put(trans);
      #3;
    end
  endtask
endclass
