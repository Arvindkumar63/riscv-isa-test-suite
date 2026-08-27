module cla(
  input  [3:0]a,b,
  input  cin,
  output [3:0]sum,
  output cout
);
  wire [3:0]g,p,c;

  // Generate and Propagate
  assign g = a&b;   // Generate
  assign p = a^b;   // Propagate

  // Carry logic
  assign c[0] = cin;
  assign c[1] = g[0] | (p[0] & c[0]);
  assign c[2] = g[1] | (p[1] & c[1]);
  assign c[3] = g[2] | (p[2] & c[2]);
  assign cout = g[3] | (p[3] & c[3]);

  // Sum
  assign sum = p^c;
endmodule

