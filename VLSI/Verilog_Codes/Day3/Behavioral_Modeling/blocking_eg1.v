module blocking_eg1;
  reg a,b;

  initial begin 
    a=1'b1;
    b=1'b0;
  end
  always @(*) begin
    $monitor("a= %b b=%b ",a,b);
    #10;
    a=1'b0;
    b=1'b1;
    #10;
    a=b;
    b=a;
    #10;
    $finish;
  end
endmodule
