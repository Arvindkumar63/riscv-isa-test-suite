module abs_value;
  reg signed[7:0]A;
  wire [7:0]out;

  function [7:0]abs_fn(input signed[7:0]A);
  begin
     if (A[7]==0) 
        abs_fn = A;
     else 
        abs_fn = -A;
  end
  endfunction

  assign out = abs_fn(A);

  initial begin
    $monitor("TIME=%0t | A=%d | out = %d",$time,A,out);
    A=8'sd20; #10;
    A=-8'sd20; #10;
    A=-8'sd25; #10;
    A=8'sd23; #10;
    $finish;
  end
endmodule
