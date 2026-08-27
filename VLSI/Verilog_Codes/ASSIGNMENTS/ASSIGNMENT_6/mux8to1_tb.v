module mux8to1_tb;
  reg [7:0]d;
  reg [2:0]sel;
  wire y;

  mux8to1 uut(.d(d),.sel(sel),.y(y));

  initial begin
    $dumpfile("mux8to1.vcd");
    $dumpvars;
    $monitor("TIME=%0t d=%b sel=%b y=%b",$time,d,sel,y);

    d=8'b00110101;
    sel=3'b000; #5;
    sel=3'b001; #5;
    sel=3'b010; #5;
    sel=3'b011; #5;
    sel=3'b100; #5;
    sel=3'b101; #5;
    sel=3'b110; #5;
    sel=3'b111; #5;
    $finish;
  end
  endmodule  
