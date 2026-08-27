module casex_problem(
  input  [3:0] sel,
  output reg [7:0] out);
  always @(*) begin
    casex(sel)      // take z and x also don't but in real hardware we don't make exact match for the unknown inputs 
      4'b1xxx: out = 8'b10101010;  
      4'b01xx: out = 8'b01010101;  
      4'b001x: out = 8'b11110000;  
      4'b0001: out = 8'b00001111;  
      default: out = 8'b11111111;
    endcase
  end
endmodule

