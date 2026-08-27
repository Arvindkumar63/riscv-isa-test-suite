// Pass by Value
module task_passbyvalue;
  int a, b;
  int out;
  
  task multiply(input int a, b, output int out);
    a = a*b; //value of a is updated, it won't update global variables a and b
    out = a;
  endtask
  
  initial begin
    a = 10;
    b = 5;
    multiply(a,b,out);
    $display("out = %0d | a = %0d | b = %0d", out, a, b);// a=10 not updated
  end
endmodule

// Pass by Reference
module task_Passbyref;
  int a, b;
  int out;
  
  task automatic multiply(ref int a, b, output int out);
    a = a*b; // update the global variable
    out = a;
  endtask
  
  initial begin
    a = 5;
    b = 6;
    multiply(a,b,out);
    $display(" out = %0d | a = %0d | b = %0d", out, a, b); //a =30 updated value
  end
endmodule
