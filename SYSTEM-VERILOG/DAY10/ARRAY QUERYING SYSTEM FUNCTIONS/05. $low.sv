// $low Returns the lowest declared bound of the 1st dimension
module array_query5; 
  typedef logic [15:0] mem_t [60:63];
  logic [7:0][15:0] myarr [10:8][3:0]; 
  mem_t mem;
  initial begin
    $display("$low of mem : %0d", $low(mem)); //60
    $display("$low of myarr : %0d", $low(myarr)); //8
  end 
endmodule
