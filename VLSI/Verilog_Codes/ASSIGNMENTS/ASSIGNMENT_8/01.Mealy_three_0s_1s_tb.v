module seq_3_0s_1s_tb;
  reg clk, reset, x;
  wire y;

  seq_3_0s_1s dut (
    .clk(clk),
    .reset(reset),
    .x(x),
    .y(y));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end


  initial begin
    $dumpfile("seq_3_0s_1s.vcd");
    $dumpvars(0, seq_3_0s_1s_tb);
    $monitor("T=%0t | reset=%b | x=%b | state=%b | next state=%b | y=%b",
              $time, reset, x, dut.state, dut.next_state, y);
    // Apply reset
    reset = 1; x = 0; 
    #5; x =1;
    #12;  
    reset = 0;

    // Sequence: 0 0 0 
    x = 0; #10;
    x = 0; #10;
    x = 0; #10;

    // Sequence: 1 1 1 
    x = 1; #10;
    x = 1; #10;
    x = 1; #10;


    // Mixed case: 0 1 0 0 0 1 1 1
    x = 0; #10;
    x = 1; #10;
    x = 0; #10;
    x = 0; #10;
    x = 0; #10; 
    x = 1; #10;
    x = 1; #10;
    x = 1; #10; 

 
    #20;
    $finish;
  end
endmodule

