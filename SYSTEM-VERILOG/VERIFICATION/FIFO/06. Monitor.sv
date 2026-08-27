class monitor #(parameter Width, Depth);
  
  virtual intf #(Width, Depth) vif;
  mailbox mon_to_scor;
  transaction #(Width)tr;
  
  function new(mailbox mon_to_scor, virtual intf #(Width, Depth) vif);
    this.mon_to_scor = mon_to_scor;
    this.vif = vif;
  endfunction
  
  task moni();
    repeat(20) begin
      @(posedge vif.clk);
      #1;
      tr = new();
      tr.rst = vif.rst;
      tr.wr_en = vif.wr_en;
      tr.rd_en = vif.rd_en;
      tr.d_in = vif.d_in;
      tr.d_out = vif.d_out;
      tr.full = vif.full;
      tr.empty = vif.empty;
      mon_to_scor.put(tr);
      tr.mon_disp("Monitor");
    end
  endtask
endclass
