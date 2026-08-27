// Logical Operators
module logical_op;
  logic [15:0]i1,i2;
  int I1;
  
  initial begin
    i1=2;
    i2=255;
    
    I1=i1->i2;
    $display("i1=%b(%0d)  i2=%b(%0d)  i1 -> i2=%0b",i1,i1,i2,i2,I1);//Expects 1
    
    
    I1=(!i1) || i2; //Equivalent to i1->i2
    $display("i1=%b(%0d)  i2=%b(%0d)  (!i1)|| i2=%0b",i1,i1,i2,i2,I1);//Expects 1
    
     I1=i1<->i2;
    $display("i1=%b(%0d)  i2=%b(%0d)  i1 <-> i2=%0b",i1,i1,i2,i2,I1);//Expects 1
    
    I1=((i1->i2)&&(i2->i1));
    $display("i1=%b(%0d)  i2=%b(%0d)  ((i1->i2)&&(i2->i1))=%0b",i1,i1,i2,i2,I1);//Expects 1
    
    i1=2;
    i2=0;
    
    I1=i1->i2;
    $display("i1=%b(%0d)  i2=%b(%0d)  i1 -> i2=%0b",i1,i1,i2,i2,I1);//Expects 0
    
    I1=i2->i1;
    $display("i1=%b(%0d)  i2=%b(%0d)  i2 -> i1=%0b",i1,i1,i2,i2,I1);//Expects 1
    
    I1=i1<->i2;
    $display("i1=%b(%0d)  i2=%b(%0d)  i1 <-> i2=%0b",i1,i1,i2,i2,I1);  // Expects 0
    
  end
endmodule
