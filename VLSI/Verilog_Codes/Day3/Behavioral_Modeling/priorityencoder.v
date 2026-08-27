module p_encode(
  input [3:0]d,
  output reg [1:0]y,
  output reg V);
     // MSB highest priority
  always @ (*) begin 
    casez (d)         // casez ignores 'z' and allows don't-care
            4'b1???: begin y = 2'b11; V = 1; end 
            4'b01??: begin y = 2'b10; V = 1; end 
            4'b001?: begin y = 2'b01; V = 1; end 
            4'b0001: begin y = 2'b00; V = 1; end 
            default: begin y = 2'bxx; V = 0; end 
     endcase
     end
endmodule
