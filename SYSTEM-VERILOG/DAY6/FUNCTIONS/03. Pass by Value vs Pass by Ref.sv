// Pass by Value
module function_passbyvalue;
  int a, b;
  int out;
  
  function int multiply(int a, b);
    a = a*b; //value of a is updated, it won't update global variables a and b
    return a;
  endfunction
  
  initial begin
    a = 10;
    b = 5;
    out = multiply(a,b);
    $display("out = %0d | a = %0d | b = %0d", out, a, b);// a=10 not updated
  end
endmodule

// Pass by Reference
module function_Passbyref;
  int a, b;
  int out;
  
  function automatic int multiply(ref int a, b);
    a = a*b; // update the global variable
    return a;
  endfunction
  
  initial begin
    a = 5;
    b = 6;
    out = multiply(a,b);
    $display(" out = %0d | a = %0d | b = %0d", out, a, b); //a =30 updated value
  end
endmodule
