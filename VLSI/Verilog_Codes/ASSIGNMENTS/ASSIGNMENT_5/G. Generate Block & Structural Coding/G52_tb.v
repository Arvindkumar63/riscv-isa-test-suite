module rca4_tb;
  reg [3:0] a,b;
  reg cin;
  wire [3:0]sum;
  wire cout;

  rca4 uut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  initial begin
    $dumpfile("rca4.vcd");
    $dumpvars(0, rca4_tb);
    $monitor("T=%0t | A=%b B=%b Cin=%b -> Sum=%b Cout=%b",
              $time, a, b, cin, sum, cout);

    a=4'b0000; b=4'b0011; cin=0; #5;
    a=4'b0001; b=4'b1001; cin=1; #5;
    a=4'b0101; b=4'b0011; cin=0; #5;
    a=4'b0110; b=4'b1011; cin=1; #5;
    a=4'b1001; b=4'b0011; cin=0; #5;
    a=4'b1111; b=4'b1111; cin=1; #5;
    #10 $finish;
  end
endmodule

