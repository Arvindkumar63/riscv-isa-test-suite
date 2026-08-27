module tb;

reg clk;
reg start;
reg signed [3:0] A;
reg signed [3:0] B;
wire signed [7:0] out;
wire done;

booth_multi  uut (
        .clk(clk), .start(start), .A(A), .B(B), .out(out), .done(done)
);

always #5 clk = ~ clk;

initial begin
        $dumpfile("booth_wave.vcd");
        $dumpvars();
        $monitor("clk=%0b | start=%0d | A=%0d | B=%0d | OUT=%0d | Done=%0d",clk,start,A,B,out,done);
        clk = 0;
        start = 0;
        @(posedge clk);
        start = 1;
        A = 4'sd3;
        B = -4'sd5;
        @(posedge clk);
        start = 0;
        #60;
        start = 1;
        A = 4'sd5;
        B = -4'sd7;
        #10;
        start = 0;
        #50;
        start = 1;
        A = 4'sd4;
        B = 4'sd7;
        #10;
        start = 0;
  #50;
        $finish;
end
endmodule
