//9. Write a test bench to test predefined array locator methods by using the following statements
// a. declare queues q, tq, dynamic array d, fixed array f
// b. initialize q to (1,3,5,7), d to (9,1,8,3,4,4), f to (1,6,2,6,8,6)
// c. display sum, product of elements of array q
// d. display min, max values stored in array q
// e. display the unique elements from array f
// f. find elements in array d with condition item > 3
// g. find indexes of those elements in array d which have condition item > 3
// h. find indexes of those elements in array d which have condition item > 99
// i. find the first index in array d which matches with condition item==8
// j. find the last element in array d which matches with condition item==4
// k. find the last index in array d which matches with condition item==4
// l. find the sum of elements in array d with condition item > 7
// m. find the sum of elements in array d with condition ((item > 7) * item)
// n. find the sum of elements in array d with condition item < 8
// o. find the sum of elements in array d with condition ((item < 8)? item:0)

module array_locator;
  int q[$] = '{1,3,5,7};
  int tq[$];
  int d[] = '{9,1,8,3,4,4};
  int f[6] = '{1,6,2,6,8,6};
  initial begin
    $display("sum of q:",q.sum());
    $display("product of q:",q.product());
    $display("min of q:",q.min());
    $display("max of q:",q.max());
    $display("unique of f=",f.unique());
    $display("item>3 elements of d=",d.find with(item>3));
    $display("item>3 indices of d=",d.find_index with(item>3));
    $display("item>99 indices of d=",d.find_index with(item>99));
    $display("First index(item==8) of d=",d.find_first_index with(item ==8));
    $display("Last element (item==4) of d=",d.find_last with(item ==4));
    $display("Last index (item==4) of d=",d.find_last_index with(item ==4));
    $display("Sum of elements with (item>7) of d=",d.sum with((item>7)*32'd1));
    $display("Sum of elements with (item>7)*item of d=",d.sum with((item >7)*item));
    $display("Sum of elements with (item<8) of d=",d.sum with(item <8));  
    $display("Sum of elements with (item<8)?item:0 of d=",d.sum with((item <8)?item:0));

  end
endmodule
