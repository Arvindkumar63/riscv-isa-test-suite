module strobe;
  reg a, b;
  wire [1:0]sum;

  assign sum=a+b;

  initial begin
    $strobe("TIME=%0t | a=%b b=%b sum=%b",$time,a,b,sum); //print values at end of simulation 
    a = 0; b = 0;
    #5;
    a = 1; b = 1;
    $strobe("TIME=%0t | a=%b b=%b sum=%b",$time,a,b,sum); //print values at end of simulation
    #5 $finish;
  end
endmodule

