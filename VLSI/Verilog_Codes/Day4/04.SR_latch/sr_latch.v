module sr_latch(
  input S, R, en, rst,
  output reg Q
);

  always @(S or R or en or rst) begin
    if (rst)
      Q <= 0;
    else if (en) begin
      case ({S, R})
        2'b10: Q <= 1;   // Set
        2'b01: Q <= 0;   // Reset
        2'b00: Q <= Q;   // Hold
        2'b11: Q <= 1'bx; // Invalid 
      endcase
    end
  end
endmodule

