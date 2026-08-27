// $size returns the number of elements in the dimension
module array_query8; 
  typedef logic [15:0] mem_t [1:63];
  logic [7:0][15:0] myarr [2:0][3:0]; 
  mem_t mem;
  initial begin 
    $display("$size of mem : %0d", $size(mem)); //63 (1 to 63)
    $display("$size of myarr : %0d", $size(myarr)); //3 (2 to 0)
  end 
endmodule
