// Default values in the argument
module task_defaultvalue;
  int a, b;
  int out;
  
  task multiply(int a=3, b=4, output int out);
    a = a*b; //value of a is updated, it won't update global variables a and b
    $display("a and b inside the function are",a,b);
    out = a;
  endtask
  
  initial begin
    multiply(.out(out));
    $display("out = %0d | a = %0d | b = %0d", out, a, b);
    a = 10;
    b = 5;
    multiply(a,b,out);
    $display("out = %0d | a = %0d | b = %0d", out, a, b);
  end
endmodule
