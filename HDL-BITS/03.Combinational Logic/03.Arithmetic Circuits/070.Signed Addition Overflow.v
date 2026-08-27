module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); 
    wire carry_msb, cout;
    wire [6:0]sum;
    assign {carry_msb,sum[6:0]}=a[6:0]+b[6:0];
    assign {cout,s} = a+b;
    assign overflow = carry_msb^cout;

endmodule
