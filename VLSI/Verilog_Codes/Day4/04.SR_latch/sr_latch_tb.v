module sr_latch_tb;
  reg S, R, en, rst;
  wire Q;

  sr_latch uut (.S(S), .R(R), .en(en), .rst(rst), .Q(Q));

  initial begin
    $dumpfile("sr_latch.vcd");
    $dumpvars;
    $monitor("TIME=%0t | S=%b | R=%b | EN=%b | RST=%b | Q=%b", $time, S, R, en, rst, Q);

    rst = 0; en = 0; S = 0; R = 0;

    #5 rst = 1;       
    #5 rst = 0; en=1; 

    #5 S=1; R=0;      
    #5 S=0; R=1;      
    #5 S=0; R=0;      
    #5 S=1; R=1;      

    #10 $finish;
  end
endmodule

