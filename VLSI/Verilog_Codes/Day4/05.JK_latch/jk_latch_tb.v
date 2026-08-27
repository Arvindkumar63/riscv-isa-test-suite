module jk_latch_tb;
  reg J, K, en, rst;
  wire Q;

  jk_latch uut (.J(J), .K(K), .en(en), .rst(rst), .Q(Q));

  initial begin
    $dumpfile("jk_latch.vcd");
    $dumpvars;
    $monitor("TIME=%0t | J=%b | K=%b | EN=%b | RST=%b | Q=%b", $time, J, K, en, rst, Q);

    rst = 0; en = 0; J = 0; K = 0;

    #5 rst = 1;       
    #5 rst = 0; en=1; 

    #5 J=1; K=0;      
    #5 J=0; K=1;      
    #5 J=0; K=0;      
    #5 J=1; K=1;      

    #10 $finish;
  end
endmodule

