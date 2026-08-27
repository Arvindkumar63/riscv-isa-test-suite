module bitwise(
    input  [3:0] x, y,
    output [3:0] notx,
    output [3:0] andxy,
    output [3:0] orxy,
    output [3:0] xorxy,
    output [3:0] xnorxy
);
    assign notx   = ~x;
    assign andxy  = x & y;
    assign orxy   = x | y;
    assign xorxy  = x ^ y;
    assign xnorxy = x ^~ y;
endmodule

