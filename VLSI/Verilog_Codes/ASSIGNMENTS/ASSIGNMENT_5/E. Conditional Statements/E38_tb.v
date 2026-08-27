module mux4to1_tb;
  reg [3:0] d;
  reg [1:0] s;
  wire y;

  mux4to1 uut (.d(d), .s(s), .y(y));

  initial begin
    $dumpfile("mux4to1.vcd");
    $dumpvars(0, mux4to1_tb);
    $monitor("T=%0t | d=%b s=%b | y=%b", $time, d, s, y);

    d=4'b1010;
    s=2'b00; #5;
    s=2'b01; #5;
    s=2'b10; #5;
    s=2'b11; #5;
    $finish;
  end
endmodule

