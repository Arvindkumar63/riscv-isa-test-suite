// Write a constraint for sorting elements in a dynamic array.
class sort_arr;
  rand int unsigned arr[];
  
  constraint c1{ arr.size() == 10; }
  
  constraint c2 { foreach(arr[i])
    if(i>0)
      arr [i] > arr[i-1]; }
endclass

module tb;
  sort_arr sa;
  initial begin 
    sa = new();
    sa.randomize();
    $display("Dynamic array(ascending order): %0p", sa.arr);
  end
endmodule


//OUTPUT
Dynamic array(ascending order): 406906912 459671005 580988244 611494781 659958272 1210390379 1292493744 1917901957 2215545682 2686030488
