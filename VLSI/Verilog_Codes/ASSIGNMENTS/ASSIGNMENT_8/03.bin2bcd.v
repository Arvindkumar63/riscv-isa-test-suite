module bin2bcd(
  input clk,
  input rst,
  input start,
  input [7:0]bin_in,
  output reg [11:0]bcd_out,
  output reg Done);

  parameter IDLE = 3'b000;
  parameter SHIFT = 3'b001;
  parameter CHECK_SHIFT_INDEX = 3'b010;
  parameter ADD = 3'b011;
  parameter CHECK_DIGIT_INDEX = 3'b100;
  parameter BCD_DONE = 3'b101;

  reg [2:0] state, next_state;
  reg [7:0] r_bin;
  reg [2:0] Loop_Count;
  reg [1:0] Digit_Index;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      bcd_out <= 0;
      r_bin <= 0;
      Loop_Count <= 0;
      Digit_Index <= 0;
      Done <= 0;
    end else begin
      state <= next_state;
      case (state)
        IDLE: begin
          Done <= 0;
          if (start) begin
            r_bin       <= bin_in;
            bcd_out     <= 0;
            Loop_Count  <= 0;
            Digit_Index <= 0;
          end
        end

        SHIFT: begin
          bcd_out <= bcd_out << 1;
          bcd_out[0] <= r_bin[7];    
          r_bin <= r_bin << 1;
        end

        CHECK_SHIFT_INDEX: begin
          if (Loop_Count == 7)
            Loop_Count <= 0;
          else
            Loop_Count <= Loop_Count + 1;
        end

        ADD: begin
          if (bcd_out[(Digit_Index*4)+:4] >= 5)
            bcd_out[(Digit_Index*4)+:4] <= bcd_out[(Digit_Index*4)+:4] + 3;
        end

        CHECK_DIGIT_INDEX: begin
          if (Digit_Index == 2)
            Digit_Index <= 0;
          else
            Digit_Index <= Digit_Index + 1;
        end

        BCD_DONE: begin
          Done <= 1;
        end
      endcase
    end
  end

  always @(*) begin
    case (state)
      IDLE: begin
        if(start) 
           next_state = SHIFT;
        else 
       	   next_state = IDLE;
      end

      SHIFT: next_state = CHECK_SHIFT_INDEX;
      CHECK_SHIFT_INDEX: next_state = (Loop_Count == 7) ? BCD_DONE : ADD;
      ADD: next_state = CHECK_DIGIT_INDEX;
      CHECK_DIGIT_INDEX: next_state = (Digit_Index == 2) ? SHIFT : ADD;
      BCD_DONE: next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end
endmodule

