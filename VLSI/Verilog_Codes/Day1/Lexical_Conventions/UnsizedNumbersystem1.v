module UnsizedNumbersystem1;
  reg unsized_dec_number = 2030;   // Unsized decimal number
  reg unsized_hex_number = 'haba;  // Unsized hexadecimal

  initial begin
    $display("Decimal Number: %d", unsized_dec_number);
    $display("Hexadecimal Number: %h", unsized_hex_number);
  end
endmodule

