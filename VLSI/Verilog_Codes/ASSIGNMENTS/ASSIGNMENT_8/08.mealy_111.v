module mealy_111(
  input clk,
  input rst, 
  input x,    
  output y );

  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b11;

  reg [1:0] state, next_state;

  always @(posedge clk or posedge rst) begin
    if (rst) 
      state <= S0;
    else 
      state <= next_state;
  end

  always @(state or x) begin
    case (state)
      S0: begin
        if (x) 
          next_state = S1;
	else 
          next_state = S0;
      end
      S1: begin
        if (x) 
          next_state = S2;
       	else 
          next_state = S0;
      end
      S2: begin
        if (x) 
          next_state = S2; 
	else 
          next_state = S0;
      end
      default: begin
          next_state = S0;
      end
    endcase
  end

  assign y = ((state == S2) && (x == 1))? 1:0;
endmodule
