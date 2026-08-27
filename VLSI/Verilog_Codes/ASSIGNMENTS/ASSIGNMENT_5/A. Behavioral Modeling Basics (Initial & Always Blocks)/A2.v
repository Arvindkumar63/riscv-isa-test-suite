module reg16;
  reg [15:0] count;

  initial begin
    count = 16'h0000;
    $monitor("Time=%2t | count=%b", $time, count);
    #200;
    $finish;
  end

  always #10 count = count + 1;  
endmodule

