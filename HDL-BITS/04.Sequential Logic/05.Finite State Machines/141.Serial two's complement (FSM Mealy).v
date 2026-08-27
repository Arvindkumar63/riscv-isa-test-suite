module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter S0 = 0, S1 = 1;
    reg state,next_state;
    
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= S0;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            S0: begin
                next_state = x ? S1:S0;
                z = x;
            end
            S1: begin
                next_state = S1;
                z = ~x;
            end
        endcase
    end
    
endmodule
