// Function with void
module func_void;
  int a,b;
  bit[7:0] out;
  function void result (int a,b);
    if(a==b) begin
      $display("A==B");
    end
    else if(a<b) begin
      $display("B>A");
    end
    else begin
      $display("A>B");
    end
  endfunction
  
  initial begin
    a=10; b=10;
    result(a,b);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
    a=11; b=40;
    result(a,b);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
    a=20; b=9;
    result(a,b);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
  end
  
endmodule
