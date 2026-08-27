module pipo_shift_tb;
  reg clk,reset;
  reg [3:0] pin;
  wire [3:0] q;

  pipo_shift uut(.clk(clk),.reset(reset),.pin(pin),.q(q));

  initial begin 
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("pipo_shift.vcd");
    $dumpvars(0,pipo_shift_tb);
  end

  initial begin
    $monitor("TIME=%0t | clk=%b | rst=%b | pin=%b | q=%b ",$time,clk,reset,pin,q);

    reset=1; #10;
    reset=0; pin=4'b1101; #10;
    pin=4'b1010; #10;
    pin=4'b1111; #20;
    $finish;
  end
endmodule

