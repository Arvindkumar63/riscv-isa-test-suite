// Function example
module func_eg;
  int a,b;
  bit[7:0] out;
  function [7:0] result (int a,b);
    if(a==b) begin
      $display("A+B");
      return a+b;
    end
    else if(a<b) begin
      $display("B-A");
      return b-a;
    end
    else begin
      $display("A-B");
      return a-b;
    end
  endfunction
  
  initial begin
    a=10; b=10;
    out = result(a,b);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
    a=11; b=40;
    out = result(a,b);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
    a=20; b=9;
    out = result(a,b);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
  end
  
endmodule
