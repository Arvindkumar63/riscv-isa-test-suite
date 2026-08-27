// Monitor
class monitor;
  transaction tr;
  mailbox moni_to_score;
  virtual inter inf;
  
  function new(virtual inter inf, mailbox moni_to_score  );
    this.moni_to_score = moni_to_score;
    this.inf = inf;
  endfunction
  
  task moni();
    tr = new();
    repeat(5) begin
      #2;
      tr.a = inf.a;
      tr.b = inf.b;
      tr.c = inf.c;
      tr.sum = inf.sum;
      tr.carry = inf.carry;
      moni_to_score.put(tr);
      tr.display("MONITOR");
      #2;
    end
  endtask
  
endclass
