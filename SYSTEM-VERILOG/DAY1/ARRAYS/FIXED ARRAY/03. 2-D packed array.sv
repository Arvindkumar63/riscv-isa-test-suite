// 2 DIMENSIONAL PACKED ARRAY
module packed2D;
  bit [2:0] [3:0] array;
  int i;
  initial begin
array = {4'd15,4'd10,4'd5};
    foreach (array[i]) begin
      $display("array[%0d] = %0d" ,i, array[i]);
    end
    array = {3{4'd6}};
    foreach (array[i]) begin
      $display("array[%0d] = %0d" ,i, array[i]);
    end
array = 12'h567;
    foreach (array[i]) begin
      $display("array[%0d] = %0d" ,i, array[i]);
    end
  end
endmodule
