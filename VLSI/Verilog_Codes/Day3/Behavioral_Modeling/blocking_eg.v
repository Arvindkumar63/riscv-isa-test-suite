module blocking_eg;
  reg a,b;
  
  initial begin 
    $monitor("a= %b b=%b ",a,b);
    #10;
    a=1'b0;
    b=1'b1;
    a=b;
    b=a;
  end
endmodule
    
    
