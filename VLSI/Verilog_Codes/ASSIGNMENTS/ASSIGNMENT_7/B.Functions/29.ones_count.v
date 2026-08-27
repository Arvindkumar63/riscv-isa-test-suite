module ones_num;
  reg [7:0]A;
  wire [3:0]count_one;

  function [3:0]ones_fn;
  input [7:0]A;
  integer i;
  begin
    ones_fn = 0;
    for(i=0;i<8;i++) begin
      if(A[i]==1)
        ones_fn = ones_fn+1;
    end
  end
  endfunction
 
  assign count_one = ones_fn(A);

  initial begin
     $monitor("TIME=%0t | A=%b | NO of ONES=%d",$time,A,count_one);
     A=8'd26; #10;
     A=8'd16; #10;
     A=8'd20; #10;
     A=8'd18; #10;
     A=8'd10; #10;
     $finish;
  end
endmodule
