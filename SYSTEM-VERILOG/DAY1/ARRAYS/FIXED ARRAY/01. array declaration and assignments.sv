// FIXED ARRAY DECLARATION & ASSIGNMENT EXAMPLE
module fixed_array;
  logic [7:0]array[0:3];
  int i;
  initial begin
    array = '{2,4,8,6}; 
    foreach (array[i]) begin
      $display("Element %0d = %0d", i, array[i]);
    end
    
    array[0]=1;
    array[1]=2;
    array[2]=3;
    array[3]=4;
    for(i=0; i<4; i=i+1) begin
      $display("Element %0d = %0d", i, array[i]);
    end
  end
endmodule
