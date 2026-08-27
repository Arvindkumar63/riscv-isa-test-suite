module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT = 2'b00, WNT = 2'b01, WT = 2'b10, ST = 2'b11;
    
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WNT;
        else 
            state <= train_valid ? next_state : state ;
    end
    
    always @(*) begin
        case(state)
            SNT: next_state = train_taken ? WNT : SNT;
            WNT: next_state = train_taken ? WT : SNT;
            WT: next_state = train_taken ? ST : WNT;
            ST: next_state = train_taken ? ST : WT;
        endcase
    end

endmodule
