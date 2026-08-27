//FA
module full_adder( input A,B,C,
                    output sum,carry);
  assign {carry,sum} = A+B+C;
endmodule

//RCA
module rca(input [3:0]A,B,
           input Cin,
           output [3:0]Sum,
           output Carry);
  wire [4:0] cout;
  assign cout[0] = Cin;

  genvar i;
  generate
	  for (i=0;i<4;i=i+1) begin
             full_adder fai(.A(A[i]), .B(B[i]), .C(cout[i]), .sum(Sum[i]), .carry(cout[i+1]));
          end
  endgenerate

  assign Carry = cout[4];
endmodule

//Testbench
module rca_tb;
  reg [3:0]A,B;
  reg Cin;
  wire [3:0]Sum;
  wire Carry;

  rca uut(A,B,Cin,Sum,Carry);

  initial begin
	  $monitor("A = %b | B = %b | C = %b | SUM = %b | CARRY = %b" , A,B,Cin,Sum,Carry);
	  A=4'b0000; B=4'b1101; Cin=1; #10; 
	  A=4'b0101; B=4'b1101; Cin=1; #10;
	  A=4'b0000; B=4'b1101; Cin=0; #10;
	  A=4'b0101; B=4'b1101; Cin=0; #10;
	  A=4'b1111; B=4'b1101; Cin=1; #10;
	  #10 $finish;
  end
  endmodule

