//Design
// takes 8 bit inputs and performs the following operations on them: addition, subtraction ,multiplication and bitwisw AND.(o/p is separate 8 bit)

module operations( input logic [7:0] a,
                  input logic [7:0] b,
                  output logic [7:0] sum,
                  output logic [7:0] diff,
                  output logic [7:0] mul,
                  output logic [7:0] b_and);
  
  assign sum = a+b;
  assign diff = a-b;
  assign mul = a*b;
  assign b_and = a&b;
endmodule

//Testbench
module tb;
  logic [7:0] a;
  logic [7:0] b;
  logic [7:0] sum;
  logic [7:0] diff;
  logic [7:0] mul;
  logic [7:0] b_and;
  
  operations o1(a,b,sum,diff,mul,b_and);
  
  initial begin
    $monitor("a = %0b(%0d) | b = %0b(%0d) : sum = %0b(%0d) | diff = %0b(%0d) | mul = %0b(%0d) | b_and = %0b(%0d) " , a, a, b, b, sum, sum, diff, diff, mul, mul, b_and, b_and);
    repeat (10)
      begin
        a = $urandom_range(0,100);
        b = $urandom_range(0,100);
        #10;
      end 
    $finish;
  end
endmodule
    
