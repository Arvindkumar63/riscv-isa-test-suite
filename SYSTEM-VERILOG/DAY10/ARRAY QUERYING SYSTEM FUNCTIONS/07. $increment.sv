// $increment returns 1 if the left bound is greater than or equal to the right bound and -1 otherwise
module array_query7; 
  typedef logic [15:0] mem_t [1:63];
  logic arr[3:0];
  logic [7:0][15:0] myarr [2:2][3:0]; 
  mem_t mem;
  initial begin 
    $display("$increment of mem : %0d", $increment(mem)); //1<63 returns -1
    $display("$increment of myarr : %0d", $increment(myarr)); //2=2 returns 1
    $display("$increment of arr : %0d", $increment(arr)); //3>0 returns 1
  end 
endmodule 
