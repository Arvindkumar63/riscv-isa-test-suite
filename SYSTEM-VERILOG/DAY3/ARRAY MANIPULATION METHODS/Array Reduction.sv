// ARRAY REDUCTION
module array_reduction;
  int arr[5]='{1,2,3,4,5};
  initial begin
    $display("SUM",arr.sum());
    $display("PRODUCT",arr.product());
    $display("AND",arr.and());
    $display("OR",arr.or());
    $display("XOR",arr.xor());
  end
endmodule
