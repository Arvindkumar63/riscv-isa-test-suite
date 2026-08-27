module encoder4to2_tb;
  reg [3:0]d;
  wire [1:0]y;

  encoder4to2 uut (
    .d(d),
    .y(y));

  initial begin
    $dumpfile("encoder4to2.vcd");
    $dumpvars(0, encoder4to2_tb);

    $display("TIME | d3 d2 d1 d0 | y1 y0");
    $monitor("%4t | %b %b %b %b | %b %b", $time, d[3], d[2], d[1], d[0], y[1], y[0]);

    d = 4'b0001; #10;  
    d = 4'b0010; #10;  
    d = 4'b0100; #10;  
    d = 4'b1000; #10;  
    d = 4'b1101; #10;
    $finish;
  end
endmodule

