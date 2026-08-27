module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    MUXDFF d0(KEY[0], SW[0], KEY[1], KEY[2], LEDR[1], LEDR[0]);
    MUXDFF d1(KEY[0], SW[1], KEY[1], KEY[2], LEDR[2], LEDR[1]);
    MUXDFF d2(KEY[0], SW[2], KEY[1], KEY[2], LEDR[3], LEDR[2]);
    MUXDFF d3(KEY[0], SW[3], KEY[1], KEY[2], KEY[3], LEDR[3]);

endmodule

module MUXDFF (
    input clk,
    input R, E, L, w,
    output Q
);
    always @(posedge clk) begin 
        if(L) 
           Q <= R;
        else begin
            if(E)
               Q <= w;
            else
               Q <= Q;
        end
    end
endmodule
