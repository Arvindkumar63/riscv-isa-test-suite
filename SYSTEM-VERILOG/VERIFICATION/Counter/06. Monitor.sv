//Monitor
class monitor;
  transaction trans;
  mailbox moni_to_scor;
  virtual inter inf;
  
  function new(virtual inter inf, mailbox moni_to_scor);
    this.inf = inf;
    this.moni_to_scor = moni_to_scor;
  endfunction
  
  task moni();
    trans = new();
    repeat(50) begin
      @(posedge inf.clk);
      //#1;
      trans.rst = inf.rst;
      trans.u_d = inf.u_d;
      trans.count = inf.count;
      moni_to_scor.put(trans);
      trans.disp("MONITOR");
    end
  endtask
endclass
