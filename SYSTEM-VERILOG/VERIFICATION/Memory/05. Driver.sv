//Driver
class driver;
  transaction trans;
  mailbox gentodrv;
  virtual inter inf;
  
  function new(virtual inter inf,mailbox gentodrv);
    this.inf = inf;
    this.gentodrv = gentodrv;
  endfunction
  
  task drv();
    trans = new();
    repeat(20) begin
      gentodrv.get(trans);
      //@ (posedge inf.clk);
      trans.disp("DRIVER");
      inf.wr <= trans.wr;
      inf.addr <= trans.addr;
      inf.data_i <= trans.data_i;
    end
  endtask
endclass
      
