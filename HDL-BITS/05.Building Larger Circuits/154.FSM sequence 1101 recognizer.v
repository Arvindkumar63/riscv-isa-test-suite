module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter S0=0, S1=1, S2=2, S3=3, SS=4;
    reg [2:0] state, next_state;
    
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
            S3: next_state = data ? SS: S0;
            SS: next_state = reset ? S0:SS;
        endcase
    end
    
    assign start_shifting = (state == SS);

endmodule
