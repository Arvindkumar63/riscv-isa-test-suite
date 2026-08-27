// Generating Consecutive elements in a 2D array
class Cons2DArr;
  rand int seq[2][5];
  constraint cons_c { foreach(seq[i,j])
    (seq[i][j] == (i*5)+j);}
endclass

module tb;
  initial begin
    Cons2DArr cns = new();
    cns.randomize();
    foreach(cns.seq[i,j])
      $display("seq[%0d][%0d] = %0d ",i,j,cns.seq[i][j]);
  end
endmodule


//OUTPUT
seq[0][0] = 0 
seq[0][1] = 1 
seq[0][2] = 2 
seq[0][3] = 3 
seq[0][4] = 4 
seq[1][0] = 5 
seq[1][1] = 6 
seq[1][2] = 7 
seq[1][3] = 8 
seq[1][4] = 9 
