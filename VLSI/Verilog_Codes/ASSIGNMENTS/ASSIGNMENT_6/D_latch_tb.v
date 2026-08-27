module d_latch_tb;
  reg d, en;
  wire q;

  d_latch uut (
    .d(d),
    .en(en),
    .q(q) );

  initial begin
    $monitor("Time=%0t | en=%b d=%b | q=%b", $time, en, d, q);

    en = 0; d = 0;

    #5  d = 1;   
    #5  en = 1;  
    #5  d = 0;   
    #5  en = 0;  
    #5  d = 1;   
    #10 en = 1;  
    #10 $finish;
  end
endmodule
