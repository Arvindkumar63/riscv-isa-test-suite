module tlatch_tb;
  reg T,en,rst;
  wire Q;

  tlatch uut (.T(T),.en(en),.rst(rst), .Q(Q));
  
  initial begin
    $dumpfile("tlatch.vcd");
    $dumpvars;
    $monitor("TIME=%0t | T=%b | Enable=%b | Reset=%b | Q=%b", $time, T, en, rst, Q);
       en = 0;
    #5 T = 1;   
    #5 en = 1;
    #5 rst=1;
    #5 T = 1; 
    #5 T = 1; 
    #5 T = 0; 

    #5 en = 1; 
    #5 rst=0;
    #5 T = 1;              
    #5 T = 0;              
    #5 T = 1;             
    #5 $finish;
  end
endmodule
