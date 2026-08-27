// Do While Loop
module do_while_example;
  int cnt;
  initial begin
    $display("Value of count outside the loop is %0d",cnt);
    do begin
      $display("Value of count =%0d",cnt);
      cnt++;
    end
    while(cnt <10);
  end
endmodule
