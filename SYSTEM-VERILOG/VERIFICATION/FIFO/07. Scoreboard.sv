class scoreboard #(parameter Width);
  
  mailbox mon_to_scor;
  transaction #(Width) tr;
  event trigger;
  
  function new(mailbox mon_to_scor);
    this.mon_to_scor = mon_to_scor;
  endfunction
  
  
  
  
  task scor();
    repeat(20) begin
      mon_to_scor.get(tr);
      tr.mon_disp("Scoreboard");
      check(tr);
      $display("------------------------------------------------------------");
      -> trigger;
    end
  endtask

logic [Width-1 : 0] queue[$];
  bit [Width-1 : 0] exp_out;

  function void check(transaction #(Width)sb_tr);
    if(sb_tr.rst) begin
    queue.delete();   // Clear queue
    exp_out = 0;
    $display("Reset Active - Ignored");
    return;
  end
  if(!sb_tr.rst) begin
    if(sb_tr.wr_en && !sb_tr.full) 
      queue.push_back(sb_tr.d_in);
    if(sb_tr.rd_en && !sb_tr.empty)
      exp_out = queue.pop_front();
  end
  else exp_out = 0;
  if(sb_tr.wr_en) begin
    $display("Write Occur");
  end
  else if((sb_tr.rd_en==1) && (sb_tr.d_out==exp_out))
    $display("Pass");
    else if((sb_tr.rd_en==1) && (sb_tr.d_out!=exp_out))
    $display("Fail");
endfunction
  
endclass
  
