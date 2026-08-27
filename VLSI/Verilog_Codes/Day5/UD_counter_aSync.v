module async_updown_counter(
  input clk,reset,up,
  output  [3:0]q);

  tff t0(.clk(clk), .reset(reset), .q(q[0]));
  tff t1(.clk(up? ~q[0] : q[0]), .reset(reset), .q(q[1]));
  tff t2(.clk(up? ~q[1] : q[1]), .reset(reset), .q(q[2]));
  tff t3(.clk(up? ~q[2] : q[2]), .reset(reset), .q(q[3]));
 
endmodule

module tff(
   input clk,reset,
   output reg q);

   always @(posedge clk or posedge reset) begin 
     if(reset)
        q<=4'b0000;
     else 
        q<=~q;
   end
endmodule
