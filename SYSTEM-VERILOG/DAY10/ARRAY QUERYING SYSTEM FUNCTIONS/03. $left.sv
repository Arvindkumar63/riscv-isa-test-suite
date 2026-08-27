//$left returns the left declared bound of 1st dimension 

module array_query3; 
  typedef logic [15:0] mem_t ;
  logic [7:0][15:0] myarr [2:0][3:0]; 
  mem_t mem;

initial begin 
  $display("$left of mem : %0d", $left(mem));//15
  $display("$left of myarr : %0d", $left(myarr));//2
end endmodule
