// Sum of N numbers in Dynamic Array
module sum_N_numbers;
  int data[];
  int result;
  function int sum_N(int ip[]);
    int sum = 0;
    foreach(ip[i])
      sum = sum + ip[i];
    return sum;
  endfunction
  initial begin
    data = new[5];
    data = '{1,2,3,4,5};
    result = sum_N(data);
    $display("Sum of N numbers is %d",result);
  end
endmodule
