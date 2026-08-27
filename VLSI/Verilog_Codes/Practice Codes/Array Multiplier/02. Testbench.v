module tb;
  reg [3:0] A, B;
  wire [7:0] prod;

  array_mult dut(.A(A), .B(B), .prod(prod));

  initial begin
    $monitor("A = %b(%0d)  |  B = %b(%0d) --> P = %b(%0d)", A, A, B, B, prod, prod);
    A = 1; B = 0; #5;
    A = 3; B = 5; #5;
    A = 7; B = 9; #5;
    A = 15; B = 15;
    #5;
    $finish;
  end
endmodule
