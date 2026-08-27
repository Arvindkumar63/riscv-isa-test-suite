// Generate Consecutive and Non-Consecutive numbers in Fixed Array
class Cons_NonCons;
  rand int cons_seq[10];
  rand int non_cons_seq[10];
  constraint c1 { foreach(cons_seq[i]) cons_seq[i] == cons_seq[0] + i;}
  constraint c2 { foreach(non_cons_seq[i]) non_cons_seq[i] == i*2;}
endclass

module tb;
  
  Cons_NonCons pkt;
  initial begin
    pkt = new();
    pkt.randomize();
    $display("consecutive = %0p | Non-Consecutive = %0p", pkt.cons_seq, pkt.non_cons_seq);
  end
endmodule

//OUTPUT
consecutive = '{363917320, 363917321, 363917322, 363917323, 363917324, 363917325, 363917326, 363917327, 363917328, 363917329} | Non-Consecutive = '{0, 2, 4, 6, 8, 10, 12, 14, 16, 18}
