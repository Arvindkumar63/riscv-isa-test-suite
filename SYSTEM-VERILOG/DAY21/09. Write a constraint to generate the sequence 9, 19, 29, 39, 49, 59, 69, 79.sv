// Write a constraint to generate the sequence 9, 19, 29, 39, 49, 59, 69, 79.
class IncrementedSeq;
  rand int seq[9];
  constraint seq_c {
    foreach(seq[i])
      seq[i] == 9 + (10*i);
  }
endclass

module tb;
  initial begin
    IncrementedSeq sq = new();
    sq.randomize();
    $display("sequence = %0p", sq.seq);
  end
endmodule


//OUTPUT
sequence = '{9, 19, 29, 39, 49, 59, 69, 79, 89}
