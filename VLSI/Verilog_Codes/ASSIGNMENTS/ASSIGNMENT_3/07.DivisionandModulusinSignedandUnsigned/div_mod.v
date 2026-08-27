module div_mod(
  input  signed[7:0] s1,s2,    // signed inputs
  input  [7:0] u1,u2,          // unsigned inputs
  output signed [7:0] sdiv,smod,// signed division & modulus
  output [7:0] udiv,umod // unsigned division & modulus
);

  // Signed operations
  assign sdiv = s1 / s2;
  assign smod = s1 % s2;

  // Unsigned operations
  assign udiv = u1 / u2;
  assign umod = u1 % u2;

endmodule

