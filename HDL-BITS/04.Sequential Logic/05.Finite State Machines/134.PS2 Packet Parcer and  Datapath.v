module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    localparam BYTE1 = 0, BYTE2 = 1, BYTE3 = 2, DONE = 3;
    reg [1:0] state, next_state;
    reg [23:0]data_path;
    
    // State transition logic (combinational) & Datapath
    always @(*) begin
        case(state) 
            BYTE1 : next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2 : next_state = BYTE3;
            BYTE3 : next_state = DONE;
            DONE : next_state = in[3] ? BYTE2 : BYTE1;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset)
            state <= BYTE1;
        else 
            state <= next_state;
    end
 
    // Output logic
    assign done = (state == DONE);
    assign out_bytes = done ? data_path : 24'd0;
    
    //Data_path
    always @(posedge clk) begin
        if(reset)
            data_path <= 24'd0;
        else data_path <= {data_path[15:0],in};
    end

endmodule
