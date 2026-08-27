module square_num;
  reg [3:0]num;
  wire [7:0]result;

  function [7:0]sqr_fn;
  input  [3:0]N;
  begin 
  sqr_fn = N**2;
  end
  endfunction
  assign result = sqr_fn(num);

  initial begin 
	  $monitor("TIME=%0t | num=%d | square_value=%d",$time,num,result);
	  num=4'd10; #10;
	  num=4'd7; #10;
	  num=4'd15; #10;
	  num=4'd5; #10;
	  num=4'd14; #10;
          #100 $finish;
  end
endmodule
