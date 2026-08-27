// Disable Randomization
class packet;
  rand bit [2:0] data1;
  randc bit [1:0] data2;
  int state;

  function void rand_mode1(int a);
    if (a==1) begin
      this.rand_mode(1);
      state = a;
    end
    else begin
      this.rand_mode(0);
      state = a;
    end
  endfunction
  
endclass

module randomization_mode;
  packet pkt;
  int c;
  
  initial begin
    pkt = new();
    $display("Before Randomization data1 = %0d data2 = %0d", pkt.data1, pkt.data2);

    if (pkt.data1.rand_mode())
      if (pkt.data2.rand_mode()) begin
        pkt.state = 1;
        $display("randomization of all variables are enabled");
      end

    for (int i = 0; i < 5; i++) begin
      c = pkt.randomize();
      if (c) $display("Randomization successful");
      else $display("Randomization failed");
      $display("[%0d] After enable the randomizations data1 = %0d, data2 = %0d", i, pkt.data1, pkt.data2);
      $display("[%0d] state = %0d", i, pkt.state);

      if (i == 3) begin
        pkt.rand_mode1(0);
        $display("[%0d] state = %0d", i, pkt.state);
    

      c = pkt.randomize();
      if (c) $display("Randomization successful");
      else $display("Randomization failed");
      $display("[%0d] After disable in the randomization data1 = %0d, data2 = %0d", i, pkt.data1, pkt.data2);
      end
    end
  end
endmodule



// All randomize return 1 -> Randomization successful.... but when randmode is disable it will stop the updation of the values....


//OUTPUT
Before Randomization data1 = 0 data2 = 0
randomization of all variables are enabled
Randomization successful
[0] After enable the randomizations data1 = 6, data2 = 2
[0] state = 1
Randomization successful
[1] After enable the randomizations data1 = 7, data2 = 0
[1] state = 1
Randomization successful
[2] After enable the randomizations data1 = 3, data2 = 3
[2] state = 1
Randomization successful
[3] After enable the randomizations data1 = 6, data2 = 1
[3] state = 1
[3] state = 0
Randomization successful
[3] After disable in the randomization data1 = 6, data2 = 1
Randomization successful
[4] After enable the randomizations data1 = 6, data2 = 1
[4] state = 0
