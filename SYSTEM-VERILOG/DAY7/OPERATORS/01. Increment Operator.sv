// Increment Operator
module increment;
  int a = 10;
  int b;
  initial begin
    //Posst increment
    b = a++;// assign a value to b and then a will increment 
    $display("After post increment:a = %0d   b = %0d", a,b);
    //Pre increment
    b = ++a;// First a increment and then it is assigned to b
    $display("After post increment:a = %0d   b = %0d", a,b);
  end
endmodule
