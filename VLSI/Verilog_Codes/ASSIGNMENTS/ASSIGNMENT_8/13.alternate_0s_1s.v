module alternate_0s_1s(
  input clk,
  input rst,
  input in,
  output reg out );

  parameter S0 = 3'b000; 
  parameter S1 = 3'b001; 
  parameter S2 = 3'b010;
  parameter S3 = 3'b011; 
  parameter S4 = 3'b100; 
  parameter S5 = 3'b101; 

  reg [2:0] state, next_state;

  always @(posedge clk or posedge rst) begin
    if (rst)
      state <= S0;
    else
      state <= next_state;
  end

  always @(state or in) begin
    case (state)
      S0: begin
        if(in) next_state = S2;
        else next_state = S1;
      end

      S1: begin
        if(in) next_state = S3; 
        else next_state = S1;
      end

      S2: begin
        if(in) next_state = S2;
        else next_state = S4; 
      end

      S3: begin
        if(in) next_state = S2; 
        else next_state = S5;   
      end

      S4: begin
        if(in) next_state = S5;
        else next_state = S1;    
      end

      S5: begin
        if(in) next_state = S2;
        else next_state = S1;
      end

      default: next_state = S0;
    endcase
  end

  always @(state) begin
    case (state)
      S5: out = 1'b1;
      default: out = 1'b0;
    endcase
  end

endmodule

