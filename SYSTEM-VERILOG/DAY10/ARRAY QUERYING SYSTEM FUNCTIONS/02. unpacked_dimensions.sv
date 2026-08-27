//unpacked dimensions returns unpacked dimensions of an array(not include unpacked data type) 
module array_query2; 
  typedef logic [15:0] mem_t [1:63][1:8]; 
  int myarr [2:0][3:0][2:0]; //returns 3 not include the data types
  logic [7:0][15:0] myarr1 [2:0][3:0][2:0]; 
  mem_t mem;

initial begin
  $display("Unpacked dimesion of mem : %0d", $unpacked_dimensions(mem_t)); 
  $display("Unpacked dimesion of myarr : %0d", $unpacked_dimensions(myarr));
  $display("Unpacked dimesion of myarr : %0d", $unpacked_dimensions(myarr1));

end 
endmodule
