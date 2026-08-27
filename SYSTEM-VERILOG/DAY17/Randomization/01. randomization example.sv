// Randomization Example
class packet;
  rand bit [2:0] addr1;
  randc bit [2:0] addr2;
endclass

module rand_methods;
  initial begin
    packet pkt = new();
    repeat (10) begin
      pkt.randomize();
      $display(" addr1 = %0d  addr2 = %0d", pkt.addr1, pkt.addr2);
      end
  end
endmodule


//OUTPUT
addr1 = 4  addr2 = 3
addr1 = 1  addr2 = 5
addr1 = 7  addr2 = 4
addr1 = 6  addr2 = 7
addr1 = 7  addr2 = 0
addr1 = 4  addr2 = 2
addr1 = 7  addr2 = 1
addr1 = 7  addr2 = 6
addr1 = 4  addr2 = 2
addr1 = 5  addr2 = 5
