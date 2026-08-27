module jkff_async_tb;
  reg clk, rst, J, K;
  wire Q, Qb;

  jk_ff_async uut (.clk(clk), .rst(rst), .J(J), .K(K), .Q(Q), .Qb(Qb));

  initial begin
    $dumpfile("jkff_async.vcd");
    $dumpvars;
    $monitor("TIME=%0t | CLK=%b | RST=%b | J=%b | K=%b | Q=%b | Qb=%b",
              $time, clk, rst, J, K, Q, Qb);

    clk = 0; rst = 0; J = 0; K = 0;

    forever #5 clk = ~clk;
  end

  initial begin
    #3 rst = 1;    
    #4 rst = 0;    
    #10 J=1; K=0;
    #10 J=0; K=1;  
    #10 J=0; K=0; 
    #10 J=1; K=1;

    #20 $finish;
  end
endmodule

