// 3 DIMENSIONAL UNPACKED ARRAY
module unpacked_3D;
  int array[3][2][1:0]='{'{'{1,2},'{7,8}},'{'{3,4},'{9,10}},'{'{5,6},'{11,12}}};
  initial begin
    foreach (array[i,j,k]) begin
      $display("array[%0d][%0d][%0d] = %0d",i,j,k,array[i][j][k]);
    end
  end
endmodule
