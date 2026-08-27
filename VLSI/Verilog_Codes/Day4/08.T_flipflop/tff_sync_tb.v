module t_ff_sync_tb;
  reg clk, rst, T;
  wire Q, Qb;

   t_ff_sync  uut (.clk(clk), .rst(rst), .T(T), .Q(Q), .Qb(Qb));

  initial begin
    $dumpfile("tff_sync.vcd");
    $dumpvars;
    $monitor("TIME=%0t | CLK=%b | RST=%b | T=%b | Q=%b | Qb=%b",
              $time, clk, rst, T, Q, Qb);

    clk = 0; rst = 0; T = 0;

    forever #5 clk = ~clk;
  end

  initial begin
    #3 rst = 1;
    #4 rst = 0;


    #10 T=1;
    #10 T=0;
    #10 T=1;

    #20 $finish;
  end
endmodule
