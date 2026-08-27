module jk(
  input clk,
  input rst,    
  input j,
  input k,
  output reg out); 

  parameter OFF = 1'b0;
  parameter ON = 1'b1; 
    
  reg state, next_state;

  always @(posedge clk or posedge rst) begin
    if(rst)
      state <= OFF;
    else
      state <= next_state;
  end

  always @(state or j or k) begin
    case(state)
      OFF: next_state= (j)? ON:OFF;
      ON: next_state=(k)? OFF:ON;
    endcase
  end

  always @(state) begin
    case(state)
      OFF: out = 1'b0;
      ON : out = 1'b1;
    endcase
  end
endmodule
