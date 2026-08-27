module more_than_one1(
  input clk,
  input rst,
  input in,
  output reg out);

  parameter S000 = 3'b000;
  parameter S001 = 3'b001;
  parameter S010 = 3'b010;
  parameter S011 = 3'b011;
  parameter S100 = 3'b100;
  parameter S101 = 3'b101;
  parameter S110 = 3'b110;
  parameter S111 = 3'b111;

  reg [2:0] state, next_state;

  always @(posedge clk or posedge rst) begin
    if (rst)
      state <= S000;
    else
      state <= next_state;
  end

  always @(state or in) begin
    case (state)
      S000: begin
        next_state = in ? S001 : S000;
        out = 0;  
      end
      S001: begin
        next_state = in ? S011 : S010;
        out = 0;  
      end
      S010: begin
        next_state = in ? S101 : S100;
        out = 0;  
      end
      S011: begin
        next_state = in ? S111 : S110;
        out = 1;  
      end
      S100: begin
        next_state = in ? S001 : S000;
        out = 0;  
      end
      S101: begin
        next_state = in ? S011 : S010;
        out = 1; 
      end
      S110: begin
        next_state = in ? S101 : S100;
        out = 1; 
      end
      S111: begin
        next_state = in ? S111 : S110;
        out = 1;  
      end
      default: begin
        next_state = S000;
        out = 0;
      end
    endcase
  end
endmodule

