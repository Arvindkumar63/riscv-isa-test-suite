module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    parameter S0=0, S1=1, S2=2, S3=3, BS0=4, BS1=5, BS2=6, BS3=7, COUNT=8, WAIT=9;
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if(reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            S0: next_state = data ? S1:S0;
            S1: next_state = data ? S2:S0;
            S2: next_state = data ? S2:S3;
            S3: next_state = data ? BS0:S0;
            BS0: next_state = BS1;
            BS1: next_state = BS2;
            BS2: next_state = BS3;
            BS3: next_state = COUNT;
            COUNT: next_state = done_counting ? WAIT:COUNT;
            WAIT: next_state = ack ? S0:WAIT;
        endcase
    end
    
    assign shift_ena = (state == BS0) || (state == BS1) || (state == BS2) || (state == BS3);
    assign counting = (state == COUNT);
    assign done = (state == WAIT);

endmodule
