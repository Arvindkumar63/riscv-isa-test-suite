module parametricmux_tb;
  reg [3:0] d0,d1,d2,d3;
  reg s0, s1;
  wire [3:0] y;

  parametricmux #(4) uut(.d0(d0), .d1(d1), .d2(d2), .d3(d3), .s0(s0), .s1(s1), .y(y));

  initial begin
    $dumpfile("parametrixmux.vcd");
    $dumpvars(0, parametricmux_tb);
    $monitor("d0 = %b | d1 = %b | d2 = %b | d3 = %b | s1 = %b | s0 = %b | y = %b",d0,d1,d2,d3,s1,s0,y);
    d0 = 4'b0001; d1 = 4'b0010; d2 = 4'b0100; d3 = 4'b1000;

    s1=0; s0=0; #10;
    s1=0; s0=1; #10;
    s1=1; s0=0; #10;
    s1=1; s0=1; #10;

    $finish;
  end
endmodule

