module siso_shift_tb;
  reg clk,reset,din;
  wire qout;
  siso_shift uut(.clk(clk),.reset(reset),.din(din),.qout(qout));
  initial begin 
    clk =0;
    forever #5 clk =~clk;
  end
  initial begin
    $dumpfile("siso_shift.vcd");
    $dumpvars(0,siso_shift_tb);
  end
    initial begin
    $monitor("TIME=%0t | clk=%b | rst=%b | din=%b | qout=%b",$time,clk,reset,din,qout);
     #10; reset=1; din=0;
     #10; din=1;
     #10; reset=0; din=0;
     #10; din=1;
     #10; din=0;
     #10; din=1;
     #10; din=0;
     #10; din=1;
     #10; din=1;
     #10;
      
      
      $finish;
    end 
endmodule
