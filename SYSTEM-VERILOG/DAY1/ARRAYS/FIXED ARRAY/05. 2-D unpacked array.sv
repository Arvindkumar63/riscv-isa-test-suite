// 2 DIMENSIONAL UNPACKED ARRAY
module unpacked_2D;
  int array[3][2]='{'{1,2},'{3,4},'{5,6}};
  int i;
  initial begin
    foreach (array[i,j]) begin
      $display("array[%0d][%0d] = %0d",i,j,array[i][j]);
    end
  end
endmodule
