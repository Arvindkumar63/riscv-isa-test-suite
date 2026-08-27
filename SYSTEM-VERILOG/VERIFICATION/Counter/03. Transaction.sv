// Transaction
class transaction;
  bit rst;
  rand bit u_d;
  bit [3:0] count;
  
  function void disp(string message);
    $display("%s", message);
    $display("Time = %0t | rst=%b | u_d=%b | count=%d",$time,rst,u_d,count);
  endfunction
  
  constraint c1 { u_d dist{1:=5, 0:=5};}
endclass
