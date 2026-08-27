// Write a constraint for a 2D array with specific constraints.
class gen_2D;
  rand int arr [4][4];
  
  constraint c1 { 
    foreach(arr[i,j])
      arr[i][j] inside {[1:99]}; 
  }
endclass

module tb;
  gen_2D g2;
  initial begin
    g2 = new();
    repeat(5) begin
      g2.randomize();
      $display("2D Array : %0p", g2.arr);
    end
  end
endmodule


//OUTPUT
# KERNEL: 2D Array : {49 44 68 34} {45 4 26 60} {18 76 6 6} {74 34 8 28}
# KERNEL: 2D Array : {97 80 17 81} {61 32 87 59} {31 38 98 61} {67 71 57 50}
# KERNEL: 2D Array : {24 3 3 27} {29 16 23 57} {58 80 36 29} {26 84 16 12}
# KERNEL: 2D Array : {20 75 95 89} {38 95 13 64} {52 69 19 44} {40 31 70 12}
# KERNEL: 2D Array : {81 31 30 94} {75 2 62 55} {27 26 41 24} {20 23 27 47}
