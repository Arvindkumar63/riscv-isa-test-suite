module divby5 (
    input  clk,
    input  rst,    
    input  bit_in,  
    output reg  div5);

    parameter S0 = 3'd0;
    parameter S1 = 3'd1;
    parameter S2 = 3'd2;
    parameter S3 = 3'd3;
    parameter S4 = 3'd4;

    reg [2:0] state, next_state;

   always @(posedge clk or posedge rst) begin
        if (rst) begin                                                                                                                                                  
            state <= S0;                                                                                                                                            
        end 
       else begin
            state <= next_state;                                                                         
        end     
   end

    always @(*) begin
        case (state)
            S0: next_state = (bit_in ? S1 : S0); 
            S1: next_state = (bit_in ? S3 : S2); 
            S2: next_state = (bit_in ? S0 : S4); 
            S3: next_state = (bit_in ? S2 : S1); 
            S4: next_state = (bit_in ? S4 : S3);
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        div5 = (state == S0);
    end

endmodule

