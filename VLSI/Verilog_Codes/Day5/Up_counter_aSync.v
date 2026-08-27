module async_up_counter (
    input clk,
    input reset,       
    output [3:0] q);

  T_ff t0 (.clk(clk), .reset(reset), .q(q[0]));
  T_ff t1 (.clk(~q[0]),.reset(reset), .q(q[1]));
  T_ff t2 (.clk(~q[1]),.reset(reset), .q(q[2]));
  T_ff t3 (.clk(~q[2]),.reset(reset), .q(q[3]));

endmodule



module T_ff (
    input clk,
    input reset,
    output reg q);

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 1'b0;
    else 
      q <= ~q; 
  end

endmodule

