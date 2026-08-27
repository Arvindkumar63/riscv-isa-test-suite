//Scoreboard
class scoreboard;
  transaction trans;
  mailbox monitoscor;
  event trigger;
  bit [7:0] memo[15:0];
  
  function new(mailbox monitoscor);
    this.monitoscor = monitoscor;
    this.trans = trans;
  endfunction
  
  task scor();
    trans = new();
    repeat(20) begin
      monitoscor.get(trans);
      trans.disp("SCOREBOARD");
      
      if(trans.wr) begin
        memo[trans.addr] = trans.data_i;
        $display("Write Pass: addr = %0d | data_in = %0d",trans.addr,trans.data_i);
      end
      else begin
        if (trans.data_o == memo[trans.addr])
          $display("Read Pass: addr = %0d | data_out = %0d",trans.addr,trans.data_o);
        else
          $error("Read Fail: addr = %0d | data_out = %0d",trans.addr,trans.data_o);
      end
      -> trigger;
      $display("---------------------------------------------------------------");
    end
  endtask
endclass
