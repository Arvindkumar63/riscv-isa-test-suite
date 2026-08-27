// Constraint to generate sequence 0102030405
class packet;
  rand int arr[10];
  
  constraint c1 { 
    foreach(arr[i])
      if(i%2 == 0)
        arr[i] == 0;
  }
  
  constraint c2 {
    foreach(arr[i])
      if(i%2 == 1)
        arr[i] == (i+1)/2;
  }
  
endclass

module tb;
  packet pkt;
  initial begin
    pkt = new();
    pkt.randomize();
    $display("Array = %0p", pkt.arr);
  end
endmodule


//OUTPUT
Array = 0 1 0 2 0 3 0 4 0 5
