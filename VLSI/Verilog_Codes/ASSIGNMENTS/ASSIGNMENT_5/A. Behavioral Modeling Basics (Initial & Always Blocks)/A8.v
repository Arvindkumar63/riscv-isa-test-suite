module two_always;
  reg x, y;

  initial begin
    x = 0; y = 0;
    $monitor("Time=%0t | x=%b y=%b", $time, x, y);
    #100;
    $finish;
  end

  always #5  x = ~x;   
  always #12 y = ~y;   
endmodule

