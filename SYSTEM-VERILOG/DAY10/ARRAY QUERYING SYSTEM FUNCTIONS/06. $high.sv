// $high returns the highest declared bound of the 1st dimension
module array_query6; 
  typedef logic [15:0] mem_t [60:63];
  logic [7:0][15:0] myarr [10:8][3:0]; 
  mem_t mem;
  initial begin
    $display("$high of mem : %0d", $high(mem)); //63
    $display("$high of myarr : %0d", $high(myarr)); //10
  end 
endmodule
