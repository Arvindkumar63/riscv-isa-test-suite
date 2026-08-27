module multiple_of_4(
  input clk,
  input rst,
  input in,         
  output reg out );

  parameter S0 = 2'b00;
  parameter S1 = 2'b01; 
  parameter S2 = 2'b10; 
  parameter S3 = 2'b11; 

  reg [1:0] state, next_state;

  always @(posedge clk or posedge rst) begin
    if (rst)
      state <= S0;
    else
      state <= next_state;
  end

  always @(state or in) begin
    case (state)
      S0: next_state = (in) ? S1 : S0;
      S1: next_state = (in) ? S2 : S1;
      S2: next_state = (in) ? S3 : S2;
      S3: next_state = (in) ? S0 : S3;
      default: next_state = S0;
    endcase
  end

  always @(state) begin
    case (state)
      S0: out = 1'b1;
      default: out = 1'b0;
    endcase
  end
endmodule

