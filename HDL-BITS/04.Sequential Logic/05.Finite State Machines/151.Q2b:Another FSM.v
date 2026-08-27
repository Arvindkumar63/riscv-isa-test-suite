module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    parameter A=0, F1=1, S0=2, S1=3, S2=4, G1=5, S3=6, G1p=7, G0p=8;
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if(!resetn)
            state <=  A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A : next_state = resetn ? F1:A;
            F1: next_state = S0;
            S0: next_state = x ? S1:S0;
            S1: next_state = x ? S1:S2;
            S2: next_state = x ? G1:S0;
            G1: next_state = y ? G1p : S3;
            S3: next_state = y ? G1p : G0p;
            G1p: next_state = resetn ? G1p:A;
            G0p: next_state = resetn ? G0p:A;
        endcase
    end
    
    assign f = (state == F1);
    assign g = (state == S3) || (state == G1) || (state == G1p);
endmodule
