// Static Casting ex
module static_casting;  
  real r_a;
  int  i_a;  
  initial begin    
    r_a = (2.1 * 3.2);    
    //real to integer conversion
    i_a = int'(r_a);   
    $display("real value is %f",r_a);
    $display("int  value is %d",i_a);
  end
endmodule

//OUTPUT
real value is 6.720000
int  value is           7
