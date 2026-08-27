//Testbench
`include "interface.sv"
`include "test.sv"

module tb;
  inter inf();
  test tst(inf);
  
  counter dut(.clk(inf.clk), .rst(inf.rst), .u_d(inf.u_d), .count(inf.count));
  
  initial begin
    inf.clk = 0;
  end
  
  always #5 inf.clk = ~ inf.clk;
  
  initial begin
    inf.rst = 1;
    #30; inf.rst = 0;
  end
  
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
    #200;
    $finish;
  end
endmodule
  
