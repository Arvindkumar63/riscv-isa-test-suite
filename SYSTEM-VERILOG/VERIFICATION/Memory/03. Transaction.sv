//Transaction
class transaction;
  rand bit wr;
  rand bit [3:0] addr;
  rand bit [7:0] data_i;
  bit [7:0] data_o;
  
  constraint wr_equal {
    wr dist { 1:=10 , 0:=10};}
  
  function void disp(string name);
    $display("---------------%0s-------------",name);
    $display("Time=%0t | wr=%0d | addr=%0d | data_in=%0d | data_out=%0d" ,$time,wr,addr,data_i,data_o);
  endfunction
endclass
