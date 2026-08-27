// Array of Queue
module array_example;
  int array [3][$];
  initial begin
    array = '{{1,2,3,4,5}, {6,7,8,9,10}, {100, 200, 300,400,500}};
    foreach (array[i,j]) $display("array[%0d][%0d] = %0d", i, j, array[i][j]);
    $display(array.size());
    array[0].push_back(10);
    array[1].push_front(20);
    array[2].pop_back();
    foreach (array[i,j]) $display("array[%0d][%0d] = %0d", i, j, array[i][j]);
    $display(array.size());
  end
endmodule
