// 1D static array randomization without using constraint 
class static_array_1D;  
  randc byte a[7];  
endclass  

module stat_array;  
  static_array_1D stat_arr;  
  initial begin  
    stat_arr = new();  
    $display("Static array - Size is already declared. So, we can only randomize the elements of it");  
    $display("rand byte a[7];");  
    $display("Before randomizing the elements of array 'a'");  
    $display("Assign by default value of array data type.");  
    $display("%0p", stat_arr.a);
    stat_arr.randomize();
    $display("After randomizing the elements of array 'a'");  
    $display("%0p", stat_arr.a);
  end
endmodule

// OUTPUT
Static array - Size is already declared. So, we can only randomize the elements of it
rand byte a[7];
Before randomizing the elements of array 'a'
Assign by default value of array data type.
'{'h0, 'h0, 'h0, 'h0, 'h0, 'h0, 'h0}
After randomizing the elements of array 'a'
'{'h8c, 'h6b, 'hc0, 'h5c, 'hd9, 'hdb, 'h94}
