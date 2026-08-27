//Driver
class driver;
  virtual fifo_intf inf;
  transaction trans;
  mailbox gentodriv;
  
  function new(mailbox gentodriv, virtual fifo_intf inf);
    this.inf = inf;
    this.gentodriv = gentodriv;
  endfunction
  
  task driv();
    repeat(50) begin
      gentodriv.get(trans);
      @(negedge inf.wclk);
      @(negedge inf.rclk);
      
      inf.w_en <= trans.w_en;
      inf.r_en <= trans.r_en;
      inf.data_in <= trans.data_in;
      #10;
      
      inf.w_en<=0;
      inf.r_en<=0;
    end
  endtask
endclass
