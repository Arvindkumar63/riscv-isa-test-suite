module neg_dff_async_reset_tb;
    reg clk, reset, d;
    wire q;
    neg_dff_async_reset uut (.clk(clk),.reset(reset),.d(d),.q(q));
    initial 
    clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1; d = 0;
        #5 reset = 0;
        #7 reset = 1; d = 1;
        #10 d = 0;
        #20 d = 1;
        #5 reset = 0;
        #20 reset = 1;
        #20 $finish;
    end

    initial begin
	    $dumpfile("neg_dff_async_reset.vcd");
	    $dumpvars;
        $monitor("Time=%0t | clk=%b reset=%b d=%b | q=%b",
                  $time, clk, reset, d,q);
    end

endmodule
