module forever_sqrwave;
  reg sig;
  initial begin
    sig = 0;
    forever #5 sig = ~sig;  
  end
  initial begin
    $dumpfile("squarewave.vcd");
    $dumpvars;
    $monitor("Time=%0t sig=%b", $time, sig);
    #100 $finish;
  end
endmodule

