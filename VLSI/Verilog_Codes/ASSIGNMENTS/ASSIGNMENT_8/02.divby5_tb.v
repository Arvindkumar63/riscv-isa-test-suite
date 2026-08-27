module divby5_tb;
    reg clk ;
    reg rst;
    reg bit_in;
    wire div5;

    initial clk =0;

    divby5 uut (
        .clk(clk),
        .rst(rst),
        .bit_in(bit_in),
        .div5(div5));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("divby5.vcd");
        $dumpvars(0, divby5_tb);

	 $monitor("Time=%0t |clk=%b| reset=%b | in=%b | out=%b | state=%b | nextstate=%b",
                 $time,clk, rst, bit_in, div5, uut.state, uut.next_state);

        rst = 1;
        bit_in = 0;
        #10 rst = 0;
        bit_in = 1;
        #10 bit_in = 0;
        #10 bit_in = 1;
        #10 bit_in = 0;
        #10 bit_in = 1;
        #10 bit_in = 0;
        #10 bit_in = 1;

        #10 rst = 1;
        #10 rst = 0;
        bit_in =1;
        #10 bit_in =1;
        #10 bit_in =1;
      	#10 bit_in =1; 
        #10;
        $finish;
    end
endmodule

