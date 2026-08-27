// CONST REF
module const_ref;
  int a, b;
  int out;
  
  function automatic int multiply(const ref int a, b);
    //a = a*b; // Compilation Error bcoz of const ref
    //return a;
    multiply = a*b;
    return multiply;
  endfunction

  initial begin
    a = 5;
    b = 6;
    out = multiply(a,b);
    $display("out = %0d | a = %0d | b = %0d", out, a, b);
  end
endmodule
