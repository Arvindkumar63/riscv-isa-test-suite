// CONST REF
module const_ref;
  int a, b;
  int out;
  
  task automatic multiply(const ref int a, b, output int out);
    //a = a*b; // Compilation Error bcoz of const ref
    //out = a;
    out = a*b;
  endtask

  initial begin
    a = 5;
    b = 6;
    multiply(a,b,out);
    $display("out = %0d | a = %0d | b = %0d", out, a, b);
  end
endmodule
