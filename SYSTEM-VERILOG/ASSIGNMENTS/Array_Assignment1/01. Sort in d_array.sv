// 1. Sort the contents of a dynamic array which contains 10 elements in it.
module array_ass1;
  int arr[];
  initial begin
    arr = new[10];
    arr = '{15,6,4,95,33,32,25,65,99,3};
    $display("Before sorting Array = %0p",arr);
    arr.sort();
    $display("After sorting Array = %0p",arr);
  end
endmodule
