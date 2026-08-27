//Testbench
`include "test.sv"
`include "interface.sv"

module tb;
  inter inf();
  test tst(inf);
  
  sram uut(.clk(inf.clk), .wr(inf.wr), .data_i(inf.data_i), .addr(inf.addr), .data_o(inf.data_o));
  
  always #5 inf.clk = ~inf.clk;
  
  initial begin
    inf.clk = 0;
    $dumpfile("dumpfile.vcd");
    $dumpvars();
    #1000;
    $finish;
  end
endmodule
  
  
