module countdown;
  integer count;

  initial begin
    count = 10;
    while (count >= 0) begin
      $display("Time=%0t count=%0d", $time, count);
      #5 count = count - 1;
    end
    $finish;
  end
endmodule

