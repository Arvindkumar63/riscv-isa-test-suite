//ASSOCIATIVE ARRAY METHODS
module associative_methods;
  longint array[int];
  int idx;
  initial begin
    idx=1;
    repeat(6) begin
      array[idx]=idx*2;
      idx = idx<<1;
    end
    if(array.first(idx))
      $display(idx,",",array[idx]);
    if(array.next(idx))
      $display(idx,",",array[idx]);
    if(array.last(idx))
      $display(idx,",",array[idx]);
    if(array.prev(idx))
      $display(idx,",",array[idx]);
    foreach (array[idx])
      $display("array[%0d] = %0d", idx, array[idx]);
    $display("size = %0d, Number of entries = %0d of array", array.size(), array.num());  
    
    if(array.exists(4)) $display("An element exists at index = 4");
    else $display("An element doesn't exists at index = 4");
    if(array.exists(7)) $display("An element exists at index = 7");
    else $display("An element doesn't exists at index = 7");
    
    array.delete(8);
    foreach (array[idx]) $display("array[%0d] = %0d", idx, array[idx]);
    $display("size = %0d, Number of entries = %0d of array", array.size(), array.num());
    
    array.delete();
    $display("size = %0d of array", array.size());
  end
endmodule
