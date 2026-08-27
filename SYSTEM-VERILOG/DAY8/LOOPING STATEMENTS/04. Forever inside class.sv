// Forever inside class
class transaction;
  int cnt;
  task inc_cnt();
    forever begin
      $display("Value of count =%0d",cnt);
      cnt++;
      #5;
    end
  endtask
endclass


module forever_example;
  transaction tr;
  initial begin
    tr = new();
    tr.inc_cnt();
  end
  
  initial begin
    #100;
    $finish;
  end
endmodule
