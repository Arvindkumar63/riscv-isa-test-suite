module SizedNumbersystem;
  reg [7:0] a, b, c, d;

  initial begin
    a = 8'd25;  
    b = 8'b11001;
    c = 8'o31; 
    d = 8'h19;   
    $display("a=%d b=%d c=%d d=%d", a, b, c, d); // Decimal Value
    $display("a=%b b=%b c=%b d=%b", a, b, c, d); // Binary Value
    $display("a=%o b=%o c=%o d=%o", a, b, c, d); // Octal Value
    $display("a=%h b=%h c=%h d=%h", a, b, c, d); // Hexadecimal Value
  end
endmodule

