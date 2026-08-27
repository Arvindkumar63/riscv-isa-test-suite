// ARRAY ORDERING
module array_ordering;
  int array[8] = '{8,3,4,6,7,1,8,5};
  initial begin
    array.reverse();
    $display(array);
    array.shuffle();
    $display(array);
    array.sort();
    $display(array);
    array.rsort();
    $display(array);
    array.shuffle();
    $display(array);
  end
endmodule
