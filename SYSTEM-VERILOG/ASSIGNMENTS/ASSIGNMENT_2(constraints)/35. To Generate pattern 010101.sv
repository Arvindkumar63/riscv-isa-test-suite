// Constraint to generate pattern 01010101
class packet;
  rand bit arr[10];
  
  constraint c1{
    foreach(arr[i])
      arr[i] == (i%2);
  }
  
endclass

module tb;
  packet pkt;
  initial begin
    pkt = new();
    pkt.randomize();
    $display("Array = %0p",pkt.arr);
  end
endmodule


//OUTPUT
Array = 0 1 0 1 0 1 0 1 0 1
