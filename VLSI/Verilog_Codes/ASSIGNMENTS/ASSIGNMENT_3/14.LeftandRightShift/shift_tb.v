module shift_tb;
  reg [3:0]in;
  wire [3:0]out1,out2;

  shift uut(in, out1, out2);

  initial begin
    $monitor("IN= %b  OUT1 = %b OUT2 = %b ",in,out1,out2);
    in=4'b1011; #10;
    in=4'b1111; #10;
    in=4'b0111; #10;
    in=4'b1110; #10;
    in=4'b0110; #10;
    $finish;
  end
endmodule
