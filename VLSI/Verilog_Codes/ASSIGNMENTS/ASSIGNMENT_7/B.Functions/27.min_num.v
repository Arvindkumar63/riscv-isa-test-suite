module min_num;
  reg [7:0]A,B;
  wire [7:0]min_out;

  function [7:0]min_fn;
  input [7:0]A,B;
  begin
  if(A<B)
    min_fn = A;
  else
    min_fn = B;
  end
  endfunction
  assign min_out = min_fn(A,B);
  
  initial begin 
    $monitor("TIME=%0t | A=%d | B=%d | MINIMUM=%d",$time,A,B,min_out);
    A=8'd10; B=8'd30; #10;
    A=8'd30; B=8'd30; #10; 
    A=8'd10; B=8'd80; #10;
    A=8'd120; B=8'd100; #10;
    A=8'd40; B=8'd30; #10;
    $finish;
  end
endmodule
