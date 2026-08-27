// 03. Dynamic Array 
module dynamic_array;
  int arr[];
  int i;
  initial begin
    arr = new[5];
    arr = '{1,2,3,4,5};
    foreach (arr[i]) 
      $display("arr[%0d] = %0d" , i, arr[i]);
    $display("SIZE = %0d",arr.size());
    arr.shuffle();
    $display(arr);
  end
endmodule
