module decoder_casez (
  input [3:0] in,
  output reg [7:0] out
);
  always @(*) begin
    casez (in)
      4'b000?: out = 8'b00000001; 
      4'b001?: out = 8'b00000010;
      4'b01??: out = 8'b00000100;
      4'b1???: out = 8'b00001000;
      default: out = 8'b00000000;
    endcase
  end
endmodule

