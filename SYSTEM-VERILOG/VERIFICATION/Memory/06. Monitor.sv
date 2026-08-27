//Monitor
class monitor;
  transaction trans;
  mailbox monitoscor;
  virtual inter inf;
  
  function new(virtual inter inf, mailbox monitoscor);
    this.inf = inf;
    this.monitoscor = monitoscor;
  endfunction
  
  task moni;
    trans = new();
    repeat(20) begin
      @(posedge inf.clk);
      trans.wr = inf.wr;
      trans.addr = inf.addr;
      trans.data_i = inf.data_i;
      trans.data_o = inf.data_o;
      monitoscor.put(trans);
      trans.disp("MONITOR");
    end
  endtask
endclass
