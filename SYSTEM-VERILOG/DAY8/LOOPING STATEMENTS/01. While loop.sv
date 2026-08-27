// While loop
module while_example;
  int cnt;
  initial begin
    $display("-----------cnt<10-----------");
    while(cnt <10)
      begin
        $display("Value of count = %0d",cnt);
        cnt++;
      end
    cnt = 0;
    $display("-----------cnt++<10-----------");
    while(cnt++ <10)
      begin
        $display("Value of count = %0d",cnt);
      end
    cnt = 0;
    $display("-----------cnt++<=10-----------");
    while(cnt++ <= 10)
      begin
        $display("Value of count = %0d",cnt);
      end
  end
endmodule
