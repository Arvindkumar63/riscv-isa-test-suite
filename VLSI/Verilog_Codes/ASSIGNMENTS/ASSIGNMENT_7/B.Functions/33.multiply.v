module multiplication;
  reg [3:0]A,B;
  wire [7:0]mul_out;

  function [7:0]multi(input [3:0]A, input  [3:0]B);
  integer i;
    begin
      multi = 0;
      for (i=0;i<B;i++)
        multi = multi + A;
    end
  endfunction
  assign mul_out = multi(A,B);
  initial begin
    $monitor("Time=%t |  A=%d  | B=%d | Mul=%d",$time,A,B,mul_out);
    A=4'd15; B=4'd15;
    #10;
    A=4'd11; B=4'd15;
    #10;
    A=4'd8; B=4'd15;
    #10;
    A=4'd10; B=4'd13;
    #10;
    #100;
    $finish;
  end 
endmodule

