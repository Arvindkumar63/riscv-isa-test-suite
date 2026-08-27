module oscillate_tb;
  reg clk, rst, A;
  wire [1:0] state;

  oscillate dut (.clk(clk), .rst(rst), .A(A), .state(state));

  initial begin
     clk = 0;
     forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("oscillator.vcd");  
    $dumpvars(0,oscillate_tb);
    $monitor("t=%0t | A=%b | state=%b", $time, A, state);
    rst = 1; A = 0;
    #15 rst = 0;   
    #50;
    A = 1; #50;    
    A = 0; #50;   
    A = 1; #10;    
    A = 0; #50;
    $finish;
    end
endmodule

