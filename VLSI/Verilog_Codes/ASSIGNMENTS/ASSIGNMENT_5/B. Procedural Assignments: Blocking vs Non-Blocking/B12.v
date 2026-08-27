module dff_blocking(
  input clk,d, 
  output reg q);

  always @(posedge clk) begin
    q = d;   // blocking
  end
endmodule
