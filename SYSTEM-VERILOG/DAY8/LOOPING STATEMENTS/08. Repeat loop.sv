// Repeat Loop
module repeat_example;
  int array[5] = '{100, 200, 300, 400, 500};
  int i;
  int cnt;
  initial begin
    repeat ($size(array)) begin // Based on size of array
      $display("array[%0d] = %0d", i, array[i]);
      i++;
    end
    
    repeat(3) begin // Repeat the statement three times
      $display("cnt = %0d", cnt);
      cnt++;
    end
  end
endmodule
