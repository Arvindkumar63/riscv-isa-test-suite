class generator #(parameter Width);
  
  transaction #(Width) tr;
  mailbox gen_to_drv;
  event trigger;
  
  function new( mailbox gen_to_drv);
    this.gen_to_drv = gen_to_drv;
  endfunction
  
  task gen();
    repeat(20) begin
      tr = new();
      tr.randomize();
      gen_to_drv.put(tr);
      tr.disp("Generator");
      @(trigger);
    end
  endtask
endclass
