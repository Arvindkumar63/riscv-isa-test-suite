// Testbench
`include "Interface.sv"
`include "test.sv"

module tb#(parameter Width=8,Depth=8);
  
  fifo_intf#(Width) inf();
  
  async_fifo dut(.wclk(inf.wclk),
                 .rclk(inf.rclk),
                 .wrst_n(inf.wrst_n),
                 .rrst_n(inf.rrst_n),
                 .w_en(inf.w_en),
                 .r_en(inf.r_en),
                 .data_in(inf.data_in),
                 .data_out(inf.data_out),
                 .full(inf.full),
                 .empty(inf.empty)
        );
  
  always #5 inf.wclk=~inf.wclk;
  always #7 inf.rclk=~inf.rclk;
  
  initial begin
    $dumpfile("FIFO.vcd");
    $dumpvars;
    
    inf.wclk=0;
    
    inf.wrst_n=0;
     inf.rclk=0;
    
    inf.rrst_n=0;
    
    #50;
    inf.wrst_n=1;
    inf.rrst_n=1;
    
    
    #1500;
    
    $finish;
  end
  
  test t1(inf);
endmodule
    
    
