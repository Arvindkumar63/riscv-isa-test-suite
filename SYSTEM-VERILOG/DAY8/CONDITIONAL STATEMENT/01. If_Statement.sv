// Simple if statement example
module if_example;
  bit[7:0] a,b;
  initial begin
    repeat(5)begin
    a=$urandom;
    b=$urandom;
      $display("a=%0d | b=%0d",a,b);
    if(a>b)
      $display("a is greater than b");
    else if(a<b)
      $display("a is less than b");
    else
      $display("a is equal to b");
  end
  end
endmodule
