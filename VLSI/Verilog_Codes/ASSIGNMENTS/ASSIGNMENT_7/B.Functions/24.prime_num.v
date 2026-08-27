module prime_num;
  reg [7:0]N;
  wire is_prime;

  function prime_fn;
  input integer n;
  integer i;
  begin
  if(n<2)
	prime_fn=0;
  else begin : loop_check
	  prime_fn=1;
	  for(i=2; i<=n/2;i++) begin 
		  if (n%i == 0) begin
	             prime_fn = 0;
		     disable loop_check;
	          end
	  end
  end
  end
endfunction

  assign is_prime=prime_fn(N);

  initial begin
    $monitor("Time=%0t | num=%0d | is_prime=%b", $time, N, is_prime);

    N = 0;  #10;
    N = 1;  #10;
    N = 2;  #10;
    N = 3;  #10;
    N = 4;  #10;
    N = 7;  #10;
    N = 9;  #10;
    N = 11; #10;
    N = 15; #10;

    #50 $finish;
  end
endmodule


