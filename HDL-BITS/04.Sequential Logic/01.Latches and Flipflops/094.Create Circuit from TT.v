module top_module (
    input clk,
    input j,
    input k,
    output Q);
    wire D;
    assign D = (j & ~Q) | (~k & Q);
    dff dff1(.d(D), .clk(clk), .Q(Q));
endmodule

module dff(
    input d,
    input clk,
    output reg Q);
    always @(posedge clk)
        Q<=d;
endmodule
