//Monitor
class monitor;
  virtual fifo_intf inf;
  transaction trans;
  mailbox monitoscor;
  
  function new(mailbox monitoscor, virtual fifo_intf inf);
    this.inf = inf;
    this.monitoscor = monitoscor;
  endfunction
  
  task moni();
    repeat(50) begin
      @(posedge inf.wclk);
      @(posedge inf.rclk);
      #1;
      
      trans = new();
      trans.wrst_n = inf.wrst_n;
      trans.rrst_n = inf.rrst_n;
      trans.w_en = inf.w_en;
      trans.r_en = inf.r_en;
      trans.data_in = inf.data_in;
      trans.data_out = inf.data_out;
      trans.full = inf.full;
      trans.empty = inf.empty;
      monitoscor.put(trans);
    end
  endtask
endclass
      
