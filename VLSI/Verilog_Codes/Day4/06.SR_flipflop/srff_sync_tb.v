module srff_sync_tb;
  reg clk, rst, S, R;
  wire Q, Qb;

  sr_ff_sync uut (.clk(clk), .rst(rst), .S(S), .R(R), .Q(Q), .Qb(Qb));

  initial begin
    $dumpfile("sr_ff.vcd");
    $dumpvars;
    $monitor("TIME=%0t | CLK=%b | RST=%b | S=%b | R=%b | Q=%b | Qb=%b",
              $time, clk, rst, S, R, Q, Qb);

    clk = 0; rst = 0; S = 0; R = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    #3 rst = 1;      
    #4 rst = 0;

    #10 S=1; R=0;   
    #10 S=0; R=1;    
    #10 S=0; R=0;    
    #10 S=1; R=1;    
    #20 $finish;
  end
endmodule

