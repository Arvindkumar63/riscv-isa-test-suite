module tb_mux4_casex;
  reg [3:0] d;
  reg [1:0] s;
  wire y;

  mux4_casex uut (.d(d), .s(s), .y(y));

  initial begin
    $dumpfile("mux4_casex.vcd");
    $dumpvars(0, tb_mux4_casex);
    $monitor("T=%0t | d=%b s=%b y=%b",$time,d,s,y);

    d=4'b1110;
    s=2'b00; #5;
    s=2'b01; #5;
    s=2'b10; #5;
    s=2'b11; #5;
    s=2'bxx; #5;
    s=2'bx1; #5;
    s=2'bzz; #5;
    $finish;
  end
endmodule

