// Forever Loop
module forever_exmaple;
  int cnt;
  initial begin
    forever begin
      $display("Value of count=%0d",cnt); // Print 0 to 5
      cnt++;
      #5;
    end
  end
  
  
  initial begin
    #30;
    $finish;
  end
endmodule


module forever_example;
  int cnt;
  initial begin
    forever begin
      $display("Value of count = %0d",cnt); // Print 0 to 9
      cnt++;
      if(cnt == 10)
        break;
    end
  end
endmodule
