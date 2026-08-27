//Scoreboard
class scoreboard;
  transaction tr;
  mailbox moni_to_scor;
  
  function new(mailbox moni_to_scor);
    this.moni_to_scor = moni_to_scor;
  endfunction
  
  task scor();
    tr = new();
    repeat(5) begin
      #3;
      moni_to_scor.get(tr);
      tr.display("Score Board");
      if({tr.carry,tr.sum} == tr.a+tr.b)
        $display("PASS");
      else
        $display("FAIL");
      #1;
    end
  endtask
endclass
