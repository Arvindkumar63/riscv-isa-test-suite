module rca4bit_tb;
  reg [3:0]a,b; 
  reg Cin;
  wire [3:0]sum;
  wire Cout;

  rca4bit uut(
  .A(a),
  .B(b),
  .Cin(Cin),
  .Sum(sum),
  .Cout(Cout));

  initial begin
    $dumpfile("rca4bit_wave.vcd");
    $dumpvars(0, rca4bit_tb);
    $display("TIME |   A   |   B   | C |  SUM  |   CARRY");
    $display("------------------------------------------");
    $monitor("%4t | %b  | %b  | %b |  %b  |   %b", $time, a, b, Cin, sum, Cout);

    a=4'b1001; b=4'b0110; Cin=0; #10;
    a=4'b1010; b=4'b1111; Cin=0; #10;
    a=4'b1101; b=4'b1010; Cin=1; #10;
    a=4'b0010; b=4'b1110; Cin=1; #10;                                                                                                                             $finish;
  end

endmodule
