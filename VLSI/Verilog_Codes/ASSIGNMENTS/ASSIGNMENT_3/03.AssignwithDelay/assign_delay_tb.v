module assign_delay_tb;
    reg a, b;
    wire  [1:0]sum;

    assign_delay uut (.a(a), .b(b), .sum(sum));

    initial begin
        $dumpfile("assign_delay.vcd");
        $dumpvars(0, assign_delay_tb);

        $monitor($time, " a=%b b=%b sum=%b", a, b, sum);

        a=0; b=0; #10;
        a=0; b=1; #10;
        a=1; b=0; #10;
        a=1; b=1; #10;

        $finish;
    end
endmodule

