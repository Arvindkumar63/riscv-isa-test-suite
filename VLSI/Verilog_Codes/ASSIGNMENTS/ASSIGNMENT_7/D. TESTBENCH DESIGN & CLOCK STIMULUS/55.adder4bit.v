// Design
module adder4(input [3:0] a, input [3:0] b, output [4:0] sum);
  assign sum = a + b;
endmodule

// Testbench
module adder4_tb;
  reg [3:0] a, b;
  wire [4:0] sum;

  adder4 uut (.a(a), .b(b), .sum(sum));

  task apply_inputs;
    begin
      a = $random %16;
      b = $random %16; #10;
      $display("a=%d b=%d sum=%d", a, b, sum);
    end
  endtask

  integer i;
  initial begin
   for(i=0;i<10;i++)
	apply_inputs();
    $finish;
  end
endmodule
