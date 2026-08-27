// $right returns the right declared bound of the first dimension
module array_query3; 
  typedef logic [15:1] mem_t ;
  logic [7:8][15:19] myarr; 
  mem_t mem;
  initial begin 
    $display("$right of mem : %0d", $right(mem)); //1
    $display("$right of myarr : %0d", $right(myarr)); //8
  end 
endmodule
