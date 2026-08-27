module nand_array_tb;
  reg [3:0] a,b;
  wire [3:0] y;

  nand_array uut(a, b, y);

  initial begin
    $dumpfile("nand_array.vcd");
    $dumpvars(0, nand_array_tb);
    $monitor("TIME = %t, A = %b , B = %b , Y = %b",$time,a,b,y);

    a=4'b1010; b=4'b1100; #10;
    a=4'b1111; b=4'b0000; #10;
    a=4'b0101; b=4'b1010; #10;

    $finish;
  end
endmodule

