//Transaction
class transaction #(parameter Width=8);
  
  bit wclk;
  bit rclk;
  bit wrst_n;
  bit rrst_n;
  
  rand bit w_en;
  rand bit r_en;
  rand bit [Width-1:0] data_in;
  bit [Width-1:0] data_out;
  bit full;
  bit empty;
  
  constraint c1{ w_en != r_en; }
endclass
