// MIXED ARRAY
module mixed_array;
  bit [2:0][3:0] array[2:0][2:0];
  initial begin
    array = '{'{12'h123,12'h456,12'h789},'{12'hABC,12'hDEF,12'h321},'{12'h645,12'h6AB,12'h734}};
    foreach (array[i,j,k]) begin
      $display("array[%0d][%0d][%0d] = %0h",i,j,k,array[i][j][k]);
    end
  end
endmodule
