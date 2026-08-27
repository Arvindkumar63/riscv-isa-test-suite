//FA 8 bit
module full_adder #( parameter N = 8)
          (input [N-1:0]A,B,
           input Cin,
           output [N-1:0]Sum,
           output Carry);
  assign {Carry,Sum} = A+B+Cin;
endmodule

//Testbench
module full_adder8bit_tb;
  parameter N = 8; //For 16 bit N =16 and based on this change test case
  reg [N-1:0]A,B;
  reg Cin;
  wire [N-1:0]Sum;
  wire Carry;

  full_adder uut(A,B,Cin,Sum,Carry);

  initial begin
	  $monitor("A = %b | B = %b | C = %b | SUM = %b | CARRY = %b" , A,B,Cin,Sum,Carry);
	  A=8'b00001111; B=8'b00001101; Cin=1; #10; 
	  A=8'b01010101; B=8'b11011010; Cin=1; #10;
	  A=8'b00001010; B=8'b10101111; Cin=0; #10;
	  A=8'b01010000; B=8'b11011111; Cin=0; #10;
	  A=8'b11100001; B=8'b11001011; Cin=1; #10;
	  #10 $finish;
  end
  endmodule
