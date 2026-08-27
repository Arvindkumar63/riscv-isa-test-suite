// 4:1 MUX
module Mux4to1(
  input [3:0]i,
  input [1:0]s,
  output y);
  wire ns0, ns1, w0, w1, w2, w3;

  not (ns0, s[0]);
  not (ns1, s[1]);

  and (w0, i[0], ns0, ns1);
  and (w1, i[1], s[0], ns1);
  and (w2, i[2], ns0, s[1]);
  and (w3, i[3], s[0], s[1]);
  or (y, w0, w1, w2, w3);

endmodule


//  8:1 MUX using 4:1 muxes 
module Mux8to1(
    input  [7:0]i,
    input  [2:0]sel,
    output y);
    wire y_lower, y_upper;

    // lower half: i[3:0]
    Mux4to1 low(.i(i[3:0]), .s(sel[1:0]), .y(y_lower));

    // upper half: i[7:4]
    Mux4to1 high(.i(i[7:4]), .s(sel[1:0]), .y(y_upper));

    // Second level (acts like 2-to-1 mux)
    //Mux4to1 m(.i({y_lower,y_upper,1'b0,1'b0}), .s({1'b0, sel[2]}), .y(y));
    Mux4to1 final(.i({1'b0, y_upper, 1'b0, y_lower}), .s({sel[2],1'b0}), .y(y));
endmodule
