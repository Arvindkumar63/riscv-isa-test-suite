// Iterator Index Querying
module iterator_index;
  int arr[8] = '{0,1,3,3,6,4,8,7};
  int q[$];
  
  initial begin
    q = arr.find(x) with (x == x.index);
    $display("Count = %0d having same index and element", q.size());
    $display("same index and elements are %p", q);
  end
endmodule
