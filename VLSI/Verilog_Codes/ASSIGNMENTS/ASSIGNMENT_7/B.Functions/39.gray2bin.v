module gray2bin;
  reg [3:0]B;
  wire [3:0]G;

  function [3:0]gray_fn;
     input [3:0]B;
     integer i;
     begin
	gray_fn[3] = B[3];
      for (i=2;i>=0;i--)
        gray_fn[i] = B[i]^B[i+1];
     end
  endfunction

  assign G=gray_fn(B);

  initial begin
	  $monitor("TIME=%0t | BINAY=%b | GRAY=%b ",$time,B,G);
	  B=4'b0000; #10;
	  B=4'b0001; #10;
	  B=4'b0010; #10;
	  B=4'b0011; #10;
	  B=4'b0100; #10;
	  B=4'b0101; #10;
	  B=4'b0110; #10;
	  B=4'b0111; #10;
	  B=4'b1000; #10;                                                                                                                                             B=4'b1001; #10;
          B=4'b1010; #10;
          B=4'b1011; #10;
          B=4'b1100; #10;
          B=4'b1101; #10;
          B=4'b1110; #10;
          B=4'b1111; #10;
          $finish;
  end
endmodule  


