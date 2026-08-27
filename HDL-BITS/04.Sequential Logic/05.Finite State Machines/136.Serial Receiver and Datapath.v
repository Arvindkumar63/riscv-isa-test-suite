module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter IDLE 	 = 3'b000,
					 START 	 = 3'b001,
					 RECEIVE = 3'b010,
					 WAIT	 = 3'b011,
					 STOP    = 3'b100;

    reg [2:0] state, next_state;
	reg [3:0] i;
    reg [7:0]data;

	always @(*) begin
		case(state)
			IDLE  : next_state = (in) ? IDLE : START;
			START : next_state = RECEIVE;
			RECEIVE : begin
				if (i == 8) begin
          if (in) next_state = STOP;
					else next_state = WAIT;
				end 
				else next_state = RECEIVE;			
			end
			WAIT : next_state = (in) ? IDLE : WAIT;
			STOP : next_state = (in) ? IDLE : START;
		endcase
	end

	always @(posedge clk) begin
		if(reset) state <= IDLE;
		else state <= next_state;
	end

	always @(posedge clk) begin
		if (reset) begin
			done <= 0;
			i <= 0;
            data <= 0; 
		end
		else begin
      case(next_state) 
				RECEIVE : begin
                    data <= {in,data[7:1]};
					done <= 0;
					i = i + 1;
				end
				STOP : begin
					done <= 1;
					i <= 0;
				end
				default : begin
					done <= 0;
					i <= 0;
				end
			endcase
		end
	end

    // New: Datapath to latch input bits.
    assign out_byte = done ? data : 8'bx;

endmodule
