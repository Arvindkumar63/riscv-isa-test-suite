module fulladder_tb;
  reg [3:0]a,b; 
  reg cin;
  wire [3:0]sum;
  wire cout;

  fulladder uut(
  .a(a),
  .b(b),
  .cin(cin),
  .sum(sum),
  .cout(cout));

  initial begin
    $dumpfile("fulladder_wave.vcd");
    $dumpvars(0, fulladder_tb);
    $display("TIME |   A   |   B   | C |  SUM  |   CARRY");
    $display("------------------------------------------");
    $monitor("%4t | %b  | %b  | %b |  %b  |   %b", $time, a, b, cin, sum, cout);

    a=4'b1001; b=4'b0110; cin=0; #10;
    a=4'b1010; b=4'b1111; cin=0; #10;
    a=4'b1101; b=4'b1010; cin=1; #10;
    a=4'b0010; b=4'b1110; cin=1; #10;                                                                                                                             $finish;
  end

endmodule
