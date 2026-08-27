module RCA_tb;
  reg [3:0]a,b; 
  reg c_in;
  wire [3:0]s;
  wire c_out;

  RCA uut(
  .a(a),
  .b(b),
  .c_in(c_in),
  .s(s),
  .c_out(c_out));

  initial begin
    $dumpfile("RCA_wave.vcd");
    $dumpvars(0, RCA_tb);
    $display("TIME |   A   |   B   | C |  SUM  |   CARRY");
    $display("------------------------------------------");
    $monitor("%4t | %b  | %b  | %b |  %b  |   %b", $time, a, b, c_in, s, c_out);

    a=4'b1001; b=4'b0110; c_in=0; #10;
    a=4'b1010; b=4'b1111; c_in=0; #10;
    a=4'b1101; b=4'b1010; c_in=1; #10;
    a=4'b0010; b=4'b1110; c_in=1; #10;                                                                                                                             $finish;
  end

endmodule
