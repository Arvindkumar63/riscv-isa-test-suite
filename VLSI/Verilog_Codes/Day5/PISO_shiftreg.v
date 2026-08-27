module piso_shift(
  input clk,reset,load,
  input [3:0] pin,
  output qout);
  reg [3:0] shift_reg;

  always @(posedge clk or posedge reset) begin
    if (reset)
      shift_reg <= 4'b0000;
    else if (load)
      shift_reg <= pin;
    else
      shift_reg <= {shift_reg[2:0],1'b0};
  end

  assign qout = shift_reg[3];
endmodule
