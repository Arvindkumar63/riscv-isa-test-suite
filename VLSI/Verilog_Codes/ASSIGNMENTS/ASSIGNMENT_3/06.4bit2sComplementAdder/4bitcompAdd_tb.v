module add2comp_tb;
  reg [3:0]a,b; 
  reg c_in;
  wire [3:0]sum;
  wire c_out;

  add2comp uut(
  .x(a),
  .y(b),
  .c_in(c_in),
  .sum(sum),
  .c_out(c_out));

  initial begin
    $dumpfile("add2comp_wave.vcd");
    $dumpvars(0, add2comp_tb);
    $display("TIME |   A   |   B   | C |  SUM  |   CARRY");
    $display("------------------------------------------");
    $monitor("%4t | %b  | %b  | %b |  %b  |   %b", $time, a, b, c_in, sum, c_out);

    a=4'b1001; b=4'b0110; c_in=0; #10;
    a=4'b1010; b=4'b1111; c_in=0; #10;
    a=4'b1101; b=4'b1010; c_in=0; #10;
    a=4'b0010; b=4'b1110; c_in=0; #10;
    a=4'b1001; b=4'b0110; c_in=1; #10;
    a=4'b1010; b=4'b1111; c_in=1; #10;
    a=4'b1101; b=4'b1010; c_in=1; #10;
    a=4'b0010; b=4'b1110; c_in=1; #10; 
    $finish;
  end

endmodule
