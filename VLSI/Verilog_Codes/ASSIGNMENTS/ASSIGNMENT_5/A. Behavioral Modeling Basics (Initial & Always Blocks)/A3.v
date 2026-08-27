module multiple_always;
  reg a, b;

  initial begin
    a = 0; b = 0;
    $monitor("Time=%2t | a=%b b=%b", $time, a, b);
    #100;
    $finish;
  end

  always #5  a = ~a;   
  always #10 b = ~b;   
endmodule

