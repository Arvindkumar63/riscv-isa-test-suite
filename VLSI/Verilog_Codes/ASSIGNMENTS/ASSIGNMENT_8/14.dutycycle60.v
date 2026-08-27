module dutycycle_60(
  input clk,
  input rst,
  output clk_60percent );

  localparam MAX_COUNT = 4;
  localparam HIGH_LEVEL = 3;
  reg [2:0]counter;
  assign clk_60percent = (counter < HIGH_LEVEL) ? 1'b1 : 1'b0;
  always @(posedge clk or posedge rst) begin
    if ((rst) || (counter == MAX_COUNT))
      counter <= 3'b0;
    else
      counter <= counter + 1;
  end
endmodule
