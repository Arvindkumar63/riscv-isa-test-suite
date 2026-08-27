module HA(
        input a,
        input b,
        output sum,
        output carry);
assign sum = a^b;
assign carry = a&b;
endmodule

module FA(
        input a,
        input b,
        input c,
        output sum,
        output carry);
assign { carry, sum } = a+b+c;
endmodule

module array_mult(
        input [3:0] A,
        input [3:0] B,
        output [7:0] prod);
wire [3:0]p0,p1,p2,p3;
wire [10:0] c;
wire [5:0] s;

genvar i;
generate for(i=0; i<4; i=i+1) begin
        and a0(p0[i], A[i], B[0]);
        and a1(p1[i], A[i], B[1]);
        and a2(p2[i], A[i], B[2]);
        and a3(p3[i], A[i], B[3]);
end
endgenerate

assign prod[0] = p0[0];

HA add1(p1[0], p0[1], prod[1], c[0]);
FA add2(p1[1], p0[2], c[0], s[0], c[1]);
FA add3(p1[2], p0[3], c[1], s[1], c[2]);
HA add4(p1[3], c[2], s[2], c[3]);
HA add5(p2[0], s[0], prod[2], c[4]);
FA add6(p2[1], s[1], c[4], s[3], c[5]);
FA add7(p2[2], s[2], c[5], s[4], c[6]);
FA add8(p2[3], c[3], c[6], s[5], c[7]);
HA add9(p3[0], s[3], prod[3], c[8]);
FA add10(p3[1], s[4], c[8], prod[4], c[9]);
FA add11(p3[2], s[5], c[9], prod[5], c[10]);
FA add12(p3[3], c[7], c[10], prod[6], prod[7]);
endmodule
