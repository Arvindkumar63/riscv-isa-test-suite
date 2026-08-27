// $dimension returns number of dimension in an array

module dimension_ex;
  int x;  // 1 dimension (take multiple bits or unpacked data type as dimension 1)
  bit b; // 0 dimension(single bit)
  logic [7:0] p1;// 1 dimension (packed)
  int u1 [5];  // 2 dimension (unpacked)(int)
  logic [15:0] mem [1:63];// 2 dimensions (packed + unpacked)
  logic [7:0][15:0] myarr [2:0][3:0];  // 4 dimensions (2 packed + 2 unpacked)
  string str = "hello";  // string → 1 dimension(unpacked data type)

  initial begin
    $display("x (int): %0d",       $dimensions(x));  
    $display("b (bit): %0d",       $dimensions(b));
    $display("p1 (packed): %0d",   $dimensions(p1));    
    $display("u1 (unpacked): %0d", $dimensions(u1));    
    $display("mem: %0d",           $dimensions(mem));   
    $display("myarr: %0d",         $dimensions(myarr)); 
    $display("string: %0d",        $dimensions(str));   
  end

endmodule
