//For loop as a while loop
module for_example;
  int cnt;
  initial begin
    for (;;) begin
      cnt++;
      $display("cnt = %0d", cnt);
      if(cnt == 10) break;
    end
  end
endmodule
