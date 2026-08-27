module multiple_initial;
  reg a, b;

  initial begin
  a = 0; #10;
  a = 1;
  end

  initial begin
  b = 0; #5;
  b = 1;
  end

  initial  
  $monitor("Time=%0t | a=%b b=%b", $time, a, b);

endmodule

