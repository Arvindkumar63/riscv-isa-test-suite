module conc_tb;
  reg [1:0]a,b,c;
  wire [3:0]y;

  conc uut (.a(a), .b(b), .c(c), .y(y));

  initial begin
    $monitor("TIME= %t | a=%b | b=%b | c=%b | y=%b",$time,a,b,c,y);
    a=2'b10; b=2'b10; c=2'b01; #10;
    a=2'b00; b=2'b11; c=2'b00; #10; 
    a=2'b11; b=2'b01; c=2'b10; #10;
    a=2'b01; b=2'b00; c=2'b11; #10;
    $finish;
  end
endmodule

