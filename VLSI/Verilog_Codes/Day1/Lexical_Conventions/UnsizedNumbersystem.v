module UnsizedNumberSystem; 
  initial begin
    $display("Decimal : %d", 25);      
    $display("Binary  : %b", 25);   // Unsized Default 32 bit
    $display("Octal   : %o", 25);
    $display("Hexa    : %h", 25);   
  end
endmodule
