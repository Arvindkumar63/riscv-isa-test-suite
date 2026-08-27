module gray_to_binary_tb;
  reg [3:0] gray;
  wire [3:0] bin;

  gray_to_binary uut(.gray(gray), .bin(bin));

  initial begin
    $dumpfile("gray2bin.vcd");
    $dumpvars(0, gray_to_binary_tb);
    $monitor("T=%0t | Gray=%b -> Bin=%b", $time, gray, bin);

    gray=4'b0000; #5;
    gray=4'b0001; #5;
    gray=4'b0010; #5;
    gray=4'b0011; #5;
    gray=4'b0100; #5;
    gray=4'b0101; #5;
    gray=4'b0110; #5;
    gray=4'b0111; #5;
    gray=4'b1000; #5;
    gray=4'b1001; #5;
    gray=4'b1010; #5;
    gray=4'b1011; #5;
    gray=4'b1100; #5;
    gray=4'b1101; #5;
    gray=4'b1110; #5;
    gray=4'b1111; #5;
    #10 $finish;
  end
endmodule

