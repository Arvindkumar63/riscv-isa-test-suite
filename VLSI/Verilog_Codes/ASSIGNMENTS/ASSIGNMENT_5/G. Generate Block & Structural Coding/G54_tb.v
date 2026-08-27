module muxN_tb;
  reg [7:0]a,b;
  reg sel;
  wire [7:0]y;

  muxN uut (.a(a), .b(b), .sel(sel), .y(y));

  initial begin
  $dumpfile("muxN.vcd");
  $dumpvars;
  $monitor("TIME=%0t a=%b b=%b sel=%b y=%b",$time,a,b,sel,y);
  a=8'b00000001; b=8'b11110000; sel=0; #5;
  a=8'b00000010; b=8'b10000000; sel=0; #5;
  a=8'b00000011; b=8'b10100000; sel=0; #5;
  a=8'b11000001; b=8'b10011110; sel=0; #5;
  a=8'b10000001; b=8'b00110011; sel=1; #5;
  a=8'b11110001; b=8'b11010100; sel=1; #5;
  a=8'b00011001; b=8'b11101010; sel=1; #5;
  a=8'b01110001; b=8'b11001100; sel=1; #5;
  a=8'b00000111; b=8'b11110000; sel=1; #5;
  $finish;
  end
endmodule

