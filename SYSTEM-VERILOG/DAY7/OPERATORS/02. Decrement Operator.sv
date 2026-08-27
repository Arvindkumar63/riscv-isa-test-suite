// Decrement Operator
module decrement;
  int a = 10;
  int b;
  initial begin
    //Posst decrement
    b = a--;// assign a value to b and then a will decrement 
    $display("After post increment:a = %0d   b = %0d", a,b);
    //Pre decrement
    b = --a;// First a decrement and then it is assigned to b
    $display("After post increment:a = %0d   b = %0d", a,b);
  end
endmodule
