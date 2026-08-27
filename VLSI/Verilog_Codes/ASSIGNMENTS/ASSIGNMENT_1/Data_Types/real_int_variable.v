module real_int_variable;
  real r;
  
  initial begin 
    $monitor("TIME= %0t, FLOAT=%0f, INTEGER=%d",$time,r,r);
    r= 4e10; #10;
    r= 2.18; #10;
    $finish;
  end

endmodule
