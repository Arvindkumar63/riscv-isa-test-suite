// 6. Write a test bench to test the dynamic array data type and its predefined methods by using the following statements
// a. declare two dynamic arrays d1, d of type int
// b. initialize d array elements with (9,1,8,3,4,4)
// c. allocate six elements in array d1
// d. initialize array d1 with index as its value
// e. display d1 and its size
// f. delete array d1
// g. reverse, sort, reverse sort, and shuffle the array d

module dyn_arr;
  int d1[];
  int d[] = '{9,1,8,3,4,4};
  initial begin
    d1 = new[6];
    foreach(d1[i]) d1[i] = i;
    $display("d1 = %0p  | Size of d1 = %0d",d1,$size(d1));
    d1.delete();
    d.reverse();
    $display("After reverse: d = %0p",d);
    d.sort();
    $display("After sort: d = %0p",d);
    d.rsort();
    $display("After rsort: d = %0p",d);
    d.shuffle();
    $display("After shuffle: d = %0p",d);
  end
endmodule
