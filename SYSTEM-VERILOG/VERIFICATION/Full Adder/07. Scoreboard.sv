//Scoreboard
class scoreboard;
  transaction tr;
  mailbox moni_to_score;
  
  function new(mailbox moni_to_score);
    this.moni_to_score = moni_to_score;
  endfunction
  
  task score();
    tr = new();
    repeat(5) begin
      #3;
      moni_to_score.get(tr);
      tr.display("SCOREBOARD");
      if({tr.carry,tr.sum} == tr.a+tr.b+tr.c)
        $display("PASS");
      else
        $display("FAIL");
      #1;
    end
  endtask
  
endclass
