module neg_dff_async_reset(
    input clk,
    input reset,
    input d,
    output reg q);
    always @(negedge clk or negedge reset) begin
        if (!reset)
            q <= 1'b0;
        else
            q <= d;
end
endmodule
