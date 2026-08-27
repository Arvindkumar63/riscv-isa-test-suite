module repeat_counter;
  reg [2:0] count;

  initial begin
    $monitor("Time=%0t count=%d", $time, count);
    count = 0;
    repeat (8) begin
      #5 count = count + 1;
    end
    $finish;
  end
endmodule

