// Sign Casting
module sign_casting;
  int a;
  bit [31:0]b;
  initial begin
    a = 255;
    b = unsigned'(a);
    $display("a=%0d b=%0d",a,b);
    a = -255;
    b = unsigned'(a);
    $display("a=%0d b=%0d",a,b);// b expects unsigned of -255 (2's complemented of 255)
    b = 4294967295;
    a = signed'(b);
    $display("a=%0d b=%0d",a,b);// a expects signed of 4294967295 (2's complement representation of bits) 
    b = 47;
    a = signed'(b);
    $display("a=%0d b=%0d",a,b);
  end
endmodule
