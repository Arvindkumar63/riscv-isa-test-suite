module parity_func;
  reg [7:0]num;
  reg parity;

  function even_parity(input [7:0]n);
  integer i;
  begin
    even_parity=0;
    for(i=0;i<=7;i++)
    begin
       even_parity=even_parity^n[i];
    end
  end
  endfunction

  initial begin
  $monitor("Time=%t | NUM=%b  | parity=%b",$time,num,parity);
  num=8'd25;
  parity=even_parity(num); #10;
  num=8'd35;
  parity=even_parity(num); #10;
  num=8'd45;
  parity=even_parity(num); #10;
  num=8'd23;
  parity=even_parity(num); #100; 
  $finish;
  end 
endmodule
