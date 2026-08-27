module factorial(input[7:0]N,output[15:0]result);

assign result = fact(7);

// define the function
  function automatic [15:0]fact;
  input [7:0]N;
    if (N==1)
      fact=1;
    else
      fact = N*fact(N-1);
   endfunction

   initial begin
    $monitor("Fact of 7 :" ,result);
    #10;
    $finish;
    end
endmodule
