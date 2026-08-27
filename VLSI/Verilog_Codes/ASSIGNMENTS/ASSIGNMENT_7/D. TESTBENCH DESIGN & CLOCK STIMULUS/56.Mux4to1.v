// Design
module mux4x1(input [3:0] in, input [1:0] sel, output y);
  assign y = in[sel];
endmodule

// Testbench
module mux_tb;
  reg [3:0]in;
  reg s0, s1;
  wire y;
  wire [1:0] sel = {s1, s0};   

  mux4x1 uut (.in(in), .sel(sel), .y(y));

  initial s0 = 0;
  always #5 s0 = ~s0;

  initial s1 = 0;
  always #10 s1 = ~s1;

  initial begin
    in = 4'b1010;   
    $monitor("t=%0t sel=%b in=%b y=%b", $time, sel, in, y);
    #50 $finish;    
  end
endmodule

