module even_odd(
  input clk,
  input rst,    
  input in,     
  output reg even_zero,
  output reg even_one );

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
      S0: begin
        if (in == 1) next_state = S1; 
        else next_state = S2; 
      end
      S1: begin
        if (in == 1) next_state = S0;
        else next_state = S3; 
      end
      S2: begin
        if (in == 1) next_state = S3; 
        else next_state = S0; 
      end
      S3: begin
        if (in == 1) next_state = S2; 
        else next_state = S1; 
      end
      default: next_state = S0;
    endcase
  end

  always @(state) begin
    case (state)
      S0: begin even_zero = 1'b1; even_one = 1'b1; end
      S1: begin even_zero = 1'b1; even_one = 1'b0; end
      S2: begin even_zero = 1'b0; even_one = 1'b1; end
      S3: begin even_zero = 1'b0; even_one = 1'b0; end
      default: begin even_zero = 1'b1; even_one = 1'b1; end
    endcase
  end

endmodule

