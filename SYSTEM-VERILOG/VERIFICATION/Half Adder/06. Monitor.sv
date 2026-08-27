//Monitor
class monitor;
  transaction tr;
  mailbox moni_to_scor;
  virtual inter inf;
 
  function new(virtual inter inf, mailbox moni_to_scor);
    this.inf = inf;
    this.moni_to_scor = moni_to_scor;
  endfunction
  
  task moni();
    tr = new();
    repeat(5) begin
      #2;
      tr.a = inf.a;
      tr.b = inf.b;
      tr.sum = inf.sum;
      tr.carry = inf.carry;
      moni_to_scor.put(tr);
      tr.display("Monitor");
      #2;
    end
  endtask
endclass
