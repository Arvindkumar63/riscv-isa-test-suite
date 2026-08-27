module SignedvsUnsigned;
  reg signed [7:0] s;  
  reg [7:0] u; //Default unsigned  

  initial begin
    s = -25;
    u = -25; // treated as unsigned

    $display("Signed s = %d", s);
    $display("Unsigned u = %d", u);
  end
endmodule

