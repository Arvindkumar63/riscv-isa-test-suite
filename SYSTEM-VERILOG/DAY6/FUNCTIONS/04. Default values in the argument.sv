// Default values in the argument
module function_passbyvalue;
  int a, b;
  int out;
  
  function int multiply(int a=3, b=4);
    a = a*b; //value of a is updated, it won't update global variables a and b
    $display("a and b inside the function are",a,b);
    return a;
  endfunction
  
  initial begin
    out = multiply();
    $display("out = %0d | a = %0d | b = %0d", out, a, b);
    a = 10;
    b = 5;
    out = multiply(a,b);
    $display("out = %0d | a = %0d | b = %0d", out, a, b);
  end
endmodule
