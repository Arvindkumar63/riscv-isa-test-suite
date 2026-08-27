module nonblocking_eg1;
  reg [1:0]a,b;
  initial begin 
  a= 2'b00;
  b= 2'b01;
  end
  always @(*) 
  begin
    $monitor("a= %b b=%b ",a,b);	  
    #10;
    a<=2'b01;
    b<=2'b11;
    #10;
    a<=b;
    b<=a;
    #10;
    $finish;
  end
endmodule

