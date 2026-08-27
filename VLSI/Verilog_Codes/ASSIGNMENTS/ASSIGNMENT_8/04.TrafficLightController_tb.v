module traffic_light_tb;
  reg clk, rst, Emg_A, Emg_B, SA, SB;
  wire RA, YA, GA, RB, YB, GB;

  traffic_light uut (.clk(clk), .rst(rst), .Emg_A(Emg_A), .Emg_B(Emg_B), .SA(SA), .SB(SB), .RA(RA), .YA(YA), .GA(GA), .RB(RB), .YB(YB), .GB(GB));

  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("traffic_light.vcd");
    $dumpvars(0,traffic_light_tb);
    $monitor("TIME=%3t | CLK=%b | RST=%b | Emg_A=%b | Emg_B=%b | SA=%b | SB=%b | RA=%b | YA=%b | GA=%b | RB=%b | YB=%b | GB=%b",
               $time,clk,rst,Emg_A,Emg_B,SA,SB,RA,YA,GA,RB,YB,GB);
    rst = 1;
    #10; rst = 0;

    #50;
    SA=1; SB=0;
    #20;
    SA=1; SB=1;
    #50;
    Emg_B=1;
    #10;
    Emg_B=0;
    #50;
    SA=0; SB=1;
    #20;
    SA=1; SB=0;
    #70;
    Emg_A=1;
    #10;
    Emg_A=0;
    $finish;
  end
endmodule




