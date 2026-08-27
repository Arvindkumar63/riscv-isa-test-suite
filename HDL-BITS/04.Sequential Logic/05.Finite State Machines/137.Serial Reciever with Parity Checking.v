module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    parameter IDLE 	 = 3'b000,
    		 RECEIVE = 3'b001,
              CHECK  = 3'b010,
              WAIT	 = 3'b011,
	   	   	  STOP   = 3'b100;

    reg [2:0] state, next_state;
	reg [3:0] i;
    reg [7:0]data;
    reg check;
    wire odd, start;

	always @(*) begin
        start = 0;
		case(state)
            IDLE  : begin
                start = 1;
                next_state = (in) ? IDLE : RECEIVE;
            end
            RECEIVE : next_state = (i == 9) ? CHECK : RECEIVE;
            CHECK: next_state = (in) ? STOP : WAIT;
			WAIT : next_state = (in) ? IDLE : WAIT;
            STOP : begin
                next_state = (in) ? IDLE : RECEIVE;
                start = 1;
            end
		endcase
	end

	always @(posedge clk) begin
		if(reset) state <= IDLE;
		else state <= next_state;
	end

	always @(posedge clk) begin
		if (reset) begin
			i <= 0;
            data <= 0; 
		end
		else begin
            case(next_state) 
				RECEIVE : begin
                    data <= {in,data[7:1]};
					i <= i + 1;
				end
				default : begin
					i <= 0;
				end
			endcase
		end
	end
    
    assign done = check && (state == STOP);

    // New: Datapath to latch input bits.
    assign out_byte = done ? data : 8'bx;

    // New: Add parity checking.
    parity p(clk, reset | start, in, odd);
    
    //checking_logic
    always@(posedge clk)
        begin        
			if(reset)            
				check <= 0;        
			else            
				check <= odd;    
		end

endmodule
