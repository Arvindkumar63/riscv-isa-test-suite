// Testbench
`include "Interface.sv"
`include "test.sv"


module fifo_tb;
  
  parameter W = 8, D = 8;
  intf #(W,D) vif();
  test #(W,D) tst(vif);
  
  sync_fifo dut(.clk(vif.clk), .rst(vif.rst), .wr_en(vif.wr_en), .rd_en(vif.rd_en), .d_in(vif.d_in), .d_out(vif.d_out), .full(vif.full), .empty(vif.empty));
  
  initial begin
    vif.clk = 0;
  end
  
  always #5 vif.clk = ~ vif.clk;
  
  initial begin
    vif.rst = 1;
    #20; vif.rst = 0;
  end
  
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
    #300;
    $finish;
  end
endmodule
  
