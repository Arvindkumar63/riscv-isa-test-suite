module nonblocking_eg2;
  reg [1:0]a,b;

  initial begin
    $monitor("TIME = %4t a= %b b=%b ",$time,a,b);
    #10;
    a<=#6 2'b00;
    b<=#5 2'b10;
    #10;
    a<= #8 b;
    b<=#3 a;
    #20;
    $finish;
  end
endmodule
