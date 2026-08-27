// Design 
module sram(
  input logic clk,
  input logic wr,
  input logic [7:0] data_i,
  input logic [3:0] addr,
  output logic [7:0] data_o);
  
  logic [7:0] mem [15:0];
  
  always @(posedge clk) begin
    if (wr)
      mem[addr] <= data_i;
    else
      data_o <= mem[addr];
  end
endmodule
