module toggle1bit;
reg sig;

  initial begin
    sig = 0;
    $monitor("Time=%0t | sig=%b", $time, sig);
    #100;
    $finish;
  end

  always #5 sig = ~sig;   

endmodule

