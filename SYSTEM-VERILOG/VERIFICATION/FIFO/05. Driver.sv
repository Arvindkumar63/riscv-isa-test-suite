class driver #(parameter Width, Depth);
  
  virtual intf #(Width, Depth) vif;
  mailbox gen_to_drv;
  transaction #(Width) tr;
  
  function new(mailbox gen_to_drv, virtual intf #(Width, Depth) vif);
    this.gen_to_drv = gen_to_drv;
    this.vif = vif;
  endfunction
  
  task drv();
    repeat(20) begin
      tr = new();
      gen_to_drv.get(tr);
      @(negedge vif.clk);
      vif.wr_en <= tr.wr_en;
      vif.rd_en <= tr.rd_en;
      vif.d_in <= tr.d_in;
      tr.disp("Driver");
    end
  endtask
endclass
