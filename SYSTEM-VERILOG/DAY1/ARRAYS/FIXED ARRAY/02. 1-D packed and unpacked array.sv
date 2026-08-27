// Single Dimension packed and unpacked array
module packed_unpacked_1D;
  logic [3:0] array[3];
  int i;
  initial begin
    array[2] = 5;
    array[1][1:0] = 'b11;
    array[0][0] = 1;
    foreach (array[i]) begin
      $display("array[%0d] = %b", i, array[i]);
    end
  end
endmodule
