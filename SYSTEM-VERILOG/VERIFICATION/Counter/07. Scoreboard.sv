//Scoreboard
class scoreboard;
  transaction trans;
  mailbox moni_to_scor;
  event trigger;
  
  function new(mailbox moni_to_scor);
    this.moni_to_scor = moni_to_scor;
  endfunction
 
  bit [3:0] exp_count;
  task scor();
    trans = new();
    repeat(50) begin
      moni_to_scor.get(trans);
      trans.disp("SCOREBOARD");
      
      if(trans.u_d && !trans.rst)
        exp_count += 1;
      else if( !trans.rst && !trans.u_d)
        exp_count -= 1;
      else 
        exp_count = 0;
      
      if((trans.rst == 1) && (trans.count == 0) || (trans.rst == 0) && (trans.count == exp_count))
        $display("----------------PASS----------------");
      else
        $display("----------------FAIL----------------|  count= %0d , exp_count = %0d " , trans.count , exp_count);
      ->trigger;
    end
  endtask
endclass
