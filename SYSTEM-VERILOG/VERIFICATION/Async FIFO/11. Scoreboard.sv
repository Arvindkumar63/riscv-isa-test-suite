//Scoreboard
class scoreboard #(parameter Width=8);
  transaction trans;
  mailbox monitoscor;
  function new(mailbox monitoscor);
    this.monitoscor = monitoscor;
    this.trans = trans;
  endfunction
  
  bit [Width-1:0] prev_exp;
  bit [Width-1:0] exp_dout;
  bit [Width-1:0]queue[$];
  
  task scor();
    trans = new();
    repeat(50) begin
      monitoscor.get(trans);
      
      if(!trans.wrst_n || !trans.rrst_n) begin
        queue.delete();
        exp_dout = 0;
        $display("Reset active ignored");
      end
      
      else begin
        if(trans.w_en && !trans.full) begin
          queue.push_back(trans.data_in);
          $display("Write Occur--------------------> Input = %0d ", trans.data_in);
        end
        if(trans.r_en && !trans.empty) begin
          prev_exp = exp_dout;
          exp_dout = queue.pop_front();
          if(trans.data_out == prev_exp)
            $display("Test Pass-------> Read Data : Actual data=%0d | Expected data=%0d ", trans.data_out, prev_exp);
          else
            $display("Test Case Fail");
        end
      end
    end
  endtask
endclass
