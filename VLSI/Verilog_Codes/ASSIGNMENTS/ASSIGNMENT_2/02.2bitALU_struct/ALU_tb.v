module alu4bit_tb;
  reg  [3:0] A,B;
  reg  [2:0] F;
  wire [3:0] Result;
  wire CarryOut,Overflow;

  alu4bit dut (
    .A(A),
    .B(B),
    .F(F),
    .Result(Result),
    .CarryOut(CarryOut),
    .Overflow(Overflow));

  initial begin
    $dumpfile("alu4bit_wave.vcd");   
    $dumpvars(0,alu4bit_tb);
    $monitor("A = %b, B = %b, F= %b, RESULT = %b, Carry = %b, Overflow = %b ",A,B,F,Result,CarryOut,Overflow);

    // Apply test values
    A = 4'b0101; B = 4'b0011; F = 3'b000; #10;  // ADD
    A = 4'b0101; B = 4'b0011; F = 3'b001; #10;  // ADD+1
    A = 4'b1111; B = 4'b0001; F = 3'b010; #10;  // SUB-1
    A = 4'b1000; B = 4'b1000; F = 3'b011; #10;  // SUB 

    A = 4'b1100; B = 4'b1010; F = 3'b100; #10;  // AND
    A = 4'b1100; B = 4'b1010; F = 3'b101; #10;  // OR
    A = 4'b1100; B = 4'b1010; F = 3'b110; #10;  // NOR
    A = 4'b1100; B = 4'b1010; F = 3'b111; #10;  // XOR

    $finish;
  end

endmodule

