// Constraint where number of 1's in one var depends on another var

class packet;
  rand int count ;
  rand bit[15:0] variable;
  
  constraint c1 {
    count_ones(variable) == count; }
  constraint c2 { 
    count inside {[1:16]}; }
  
  function int count_ones(bit[15:0] n);
    int i;
    int c = 0;
    foreach (n[i])
      c += n[i];
    return c;
  endfunction
  
endclass

module tb;
  packet pkt ;
  initial begin
    pkt = new();
    repeat(10) begin
      pkt.randomize();
      $display("variable = %0b | count = %0d", pkt.variable,pkt.count);
    end
  end
endmodule


//OUTPUT
# KERNEL: variable = 1111001101000110 | count = 9
# KERNEL: variable = 1110010100101 | count = 7
# KERNEL: variable = 1011101100100011 | count = 9
# KERNEL: variable = 1001001011010100 | count = 7
# KERNEL: variable = 1110111011111 | count = 11
# KERNEL: variable = 1111100110101101 | count = 11
# KERNEL: variable = 1111010110111011 | count = 12
# KERNEL: variable = 10111101011000 | count = 8
# KERNEL: variable = 1000100110000111 | count = 7
# KERNEL: variable = 11011011011000 | count = 8
