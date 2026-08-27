// 1-bit full adder
module full_adder(
  input a,b,cin,
  output sum, cout);
  wire g, x, y, z;

  xor(g, a, b);
  xor(sum, g, cin);
  and(x, a, b);
  and(y, b, cin);       
  and(z, cin, a);        
  or(cout, x, y, z);

endmodule

// 4-bit ripple carry adder 
module rca4bit(
    input [3:0] A,B,
    input Cin,
    output [3:0] Sum,
    output Cout);
  wire c0, c1, c2;

  full_adder fa0(.a(A[0]), .b(B[0]), .cin(Cin), .sum(Sum[0]), .cout(c0));
  full_adder fa1(.a(A[1]), .b(B[1]), .cin(c0),  .sum(Sum[1]), .cout(c1));
  full_adder fa2(.a(A[2]), .b(B[2]), .cin(c1),  .sum(Sum[2]), .cout(c2));
  full_adder fa3(.a(A[3]), .b(B[3]), .cin(c2),  .sum(Sum[3]), .cout(Cout));
endmodule

