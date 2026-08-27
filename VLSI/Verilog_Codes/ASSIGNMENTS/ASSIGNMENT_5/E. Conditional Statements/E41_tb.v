module encoder4to2_tb;
  reg [3:0] d;
  wire [1:0] y;

  encoder4to2 uut (.d(d), .y(y));

  initial begin
    $dumpfile("encoder4to2.vcd");
    $dumpvars(0, encoder4to2_tb);
    $monitor("T=%0t | d=%b | y=%b", $time, d, y);

    d=4'b0001; #5;
    d=4'b0010; #5;
    d=4'b0100; #5;
    d=4'b1000; #5;
    $finish;
  end
endmodule

