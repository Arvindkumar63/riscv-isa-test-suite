module even_odd_tb;
  reg clk, rst, in;
  wire even_zero, even_one;

  even_odd uut ( .clk(clk), .rst(rst), .in(in), .even_zero(even_zero), .even_one(even_one) );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  initial begin
    $dumpfile("even_odd.vcd");
    $dumpvars(0, even_odd_tb);
    $monitor("Time=%0t | rst=%b | in=%b | even_zero=%b | even_one=%b", $time, rst, in, even_zero, even_one);
    rst = 1; in = 0;
    #15 rst = 0;

    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;

    #20 $finish;
  end
endmodule

