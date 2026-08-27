// foreach constraint 
class packet;
  rand bit[3:0] arr1[4];
  rand bit[3:0] arr2[];
  
  constraint c1 {
    foreach(arr1[i])
      arr1[i] == i*2;
  }
  constraint c2 { arr2.size == 5;
                 foreach(arr2[i])
                   arr2[i] == i*3;
  }
endclass

module tb;
  initial begin
    packet pkt = new();
    void'(pkt.randomize());
    $display("%0p",pkt.arr1);
    $display("%0p",pkt.arr2);
  end
endmodule


//OUTPUT
'{'h0, 'h2, 'h4, 'h6}
'{'h0, 'h3, 'h6, 'h9, 'hc}
