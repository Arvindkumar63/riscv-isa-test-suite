// Unique If statement
module unique_if_example;  
  initial begin
    int a, b;
    a = 10;
    b = 20;
    unique if(a>b)
      $display("a is greater than b");
    else if(a<b)
      $display("a is less than b");
    else 
      $display("a is equal to b");
  end
endmodule

// In unique if-> None of if conditions are true or there is no ‘else’ statement Warning occur
//In unique if-> More than one if or else if conditions are true Warning occur
//--------------------------------------------------------------

//Unique0 if
module unique0_if_example;  
  initial begin
    int a, b;
    a = 10;
    b = 20;
    unique0 if(a>30)
      $display("a is greater than 30");
    else if(30<b)
      $display("30 is less than b");
  end
endmodule

//In unique0 -> No run time warning is expected even if there is no ‘if’/ ‘else if’ a condition is true or else the condition is missing
//-------------------------------------------------------------

//Priority if
module priority_if_example;  
  initial begin
    int a, b;
    a = 20;
    b = 10;
    priority if(a>b)
      $display("a is greater than b");
    else if(b<a)
      $display("b is less than a");
    else 
      $display("a is equal to b");
  end
endmodule

//In priority if -> None of ‘if’ conditions are true or there is no ‘else’ statement warning is expected
