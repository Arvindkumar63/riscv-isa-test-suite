module comparator4bit_tb;
  reg  [3:0] a,b;
  wire eq,gt,lt;

  comparator4bit uut(.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));

  initial begin
    $dumpfile("comparator4bit.vcd");
    $dumpvars(0, comparator4bit_tb);
    $monitor("Time=%0t | a=%b b=%b | eq=%b gt=%b lt=%b",
              $time, a, b, eq, gt, lt);

    a=4'b0101; b=4'b0101; #10; // equal
    a=4'b1010; b=4'b0111; #10; // greater
    a=4'b0011; b=4'b1000; #10; // less
    a=4'b1111; b=4'b0000; #10; // greater
    $finish;
  end
endmodule

