module siso3bit(
  input clk,rst,din,
  output reg q_out);
  reg q1,q2;

  always @(posedge clk or posedge rst) begin
    if (rst) begin 
    q1<=1'b0;
    q2<=1'b0;
    q_out<=1'b0;
    end
    else begin 
    q1<=din;
    q2<=q1;
    q_out<=q2;
    end
  end
endmodule
