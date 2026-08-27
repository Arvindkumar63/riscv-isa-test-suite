module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter S0=0, S1=1, S2=2, S3=3, BS0=4, BS1=5, BS2=6, BS3=7, COUNT=8, WAIT=9;
    reg [3:0] state, next_state;
    reg [9:0]count_1000;
    
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
            COUNT: next_state = (count == 0 && count_1000==999) ? WAIT:COUNT;
            WAIT: next_state = ack ? S0:WAIT;
        endcase
    end
    
    always @(posedge clk) begin
        case(state)
            BS0,BS1,BS2,BS3: count <= {count[2:0],data};
            COUNT: begin
                if(count >= 0) begin
                    if(count_1000<999)
                        count_1000 = count_1000 + 1;
                    else begin
                        count = count - 1;
                        count_1000 = 0;
                    end
                end
            end
            default: count_1000 = 0;
        endcase
    end
                
    
    assign counting = (state == COUNT);
    assign done = (state == WAIT);

endmodule
