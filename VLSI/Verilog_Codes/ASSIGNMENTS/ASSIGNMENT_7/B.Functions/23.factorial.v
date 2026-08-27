module factorial;
  reg [7:0]n;
  wire [15:0]result;

  function automatic [15:0]fact;
  input[7:0]N;
    if(N==1)
      fact=1;
    else
      fact=N*fact(N-1);
  endfunction

  assign result = fact(n);

  initial begin
    $monitor("Factorial of %d= %d",n,result);
    n=2; #10;
    n=3; #10;
    n=4; #10;
    n=5; #10;
    $finish;
  end
endmodule
