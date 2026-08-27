// Write a constraint to print the pattern 122112211.
class pattern;
  rand int arr[9];
  constraint c1{
    foreach(arr[i])
      if( (i%4 ==0) || (i%4 == 3))
        arr[i] == 1;}
  constraint c2{
    foreach(arr[i])
      if( (i%4 ==1) || (i%4 == 2))
        arr[i] == 2;}
endclass

module pattern_test;
  pattern p;
  initial begin
    p = new();
    p.randomize();
    $display("Array = %0p", p.arr);
  end
endmodule

//OUTPUT
Array = 1 2 2 1 1 2 2 1 1
