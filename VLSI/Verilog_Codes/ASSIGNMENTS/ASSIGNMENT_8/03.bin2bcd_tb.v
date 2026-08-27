module bin2bcd_tb;
  reg clk;
  reg rst;
  reg [7:0]bin_in;
  reg start;
  wire [11:0]bcd_out;
  wire Done;

  bin2bcd uut ( .clk(clk), .rst(rst), .start(start), .bin_in(bin_in), .bcd_out(bcd_out), .Done(Done) );

  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin 
    $dumpfile("bin2bcd.vcd");
    $dumpvars;
    $monitor("TIME = %0t | RST = %b | START = %b | Binary_in = %b | STATE = %b | NEXT_STATE = %b | BCD_OUT = %b | DONE = %b ",
              $time,      rst,       start,       bin_in,          uut.state,   uut.next_state,   bcd_out       , Done);
    bin_in = 8'b11111111;
    rst = 1; 
    #10;
    rst = 0;
    start = 0;
    #5;
    start = 1;
    #1200;
    
   
   $finish;
   end
endmodule                                  
