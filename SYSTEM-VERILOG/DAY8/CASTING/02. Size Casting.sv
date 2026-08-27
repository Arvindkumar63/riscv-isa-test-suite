// Size Casting
module size_casting;
  logic [15:0] a,b,c, sum;
  logic carry;
  initial begin
    $monitor("a=%0d b=%0d c= %0d sum=%0d carry=%0d",a,b,c,sum,carry);
    a = 16'(6);
    b = 16'(7);
    c = 16'(5);
    #10;
    sum = a + 16'(5);
    #10;
    {carry, sum } = 17'(a+b);
    #10;
    sum = a + 16'(b-2)/c;
    #10;
  end
endmodule
