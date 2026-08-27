module div_mod_tb;
  reg  signed [7:0]s1,s2;
  reg  [7:0]u1,u2;
  wire signed [7:0]sdiv,smod;
  wire [7:0] udiv,umod;

  div_mod uut (.s1(s1), .s2(s2), .u1(u1), .u2(u2),.sdiv(sdiv), .smod(smod), .udiv(udiv), .umod(umod));

  initial begin
    $monitor("Time=%0t | s1=%0d s2=%0d | sdiv=%0d smod=%0d | u1=%0d u2=%0d | udiv=%0d umod=%0d",
              $time, s1, s2, sdiv, smod, u1, u2, udiv, umod);

    // Unsigned case
    u1=17; u2=5; s1=0; s2=1; #5;

    u1=-17; u2=5; s1=1; s2=1; #5;//interpret -17 as 239

    // Signed +/+
    s1=17; s2=5; u1=0; u2=1; #5;

    // Signed -/+
    s1=-17; s2=5; #5;

    // Signed +/-
    s1=17; s2=-5; #5;

    // Signed -/-
    s1=-17; s2=-5; #5;

    $finish;
  end
endmodule

