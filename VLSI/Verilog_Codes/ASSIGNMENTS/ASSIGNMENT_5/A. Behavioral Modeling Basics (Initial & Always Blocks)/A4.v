module diff;
  reg x, y;

  initial begin
    x = 1;  y = 0;  
    #10;
    x = ~x;
  end

  always #5 y = ~y;   

  initial begin
  $monitor("%0t  %b  %b", $time,x,y);
  #100;
  $finish;
  end

endmodule

