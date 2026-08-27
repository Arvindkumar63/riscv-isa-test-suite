// Write a constraint to generate alternating pairs of 0 and 1.
class alt_pairs;
  rand bit value[32];
  
  constraint c1{
    foreach(value[i])
      if(i%2 == 0)
        value[i] == value[i+1];
  }
  
  constraint c2{
    foreach(value[i])
      if(i%2 != 0)
        value[i] != value[i+1];
  }
endclass

module tb;
  alt_pairs p;
  initial begin
    p = new();
    p.randomize();
    $display("Array = %0p", p.value);
  end
endmodule



//OUTPUT
Array = 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1
