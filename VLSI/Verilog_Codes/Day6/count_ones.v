module count_ones(
  input [7:0]data,
  output [3:0]count);

  function [3:0]count_one(input [7:0]A);
    integer i;
    begin
    count_one=0;
    for(i=0;i<8;i++) begin
     if(A[i]==1)
      count_one=count_one+1;
    end
  end
endfunction
  assign count = count_one(data);
endmodule
