module oscillate(
  input clk,
  input rst,
  input A,
  output reg [1:0]state);
  reg [1:0] next_state;
  reg sel;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
       state <= 2'b00;
       sel <= 0;
    end
    else begin
       state <= next_state;
       if (A)
	sel <= ~sel;
    end 
  end

  always @(*) begin
    case (sel)
      1'b0: begin 
         if (state == 2'b00) next_state = 2'b01;
         else if (state == 2'b01) next_state = 2'b00;
         else next_state = 2'b00; 
      end

      1'b1: begin
         if (state == 2'b10) next_state = 2'b11;
         else if (state == 2'b11) next_state = 2'b10;
         else next_state = 2'b10; 
      end
    endcase
  end
endmodule
