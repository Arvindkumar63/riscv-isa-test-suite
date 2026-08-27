module piso_shift_tb;
  reg clk,reset,load;
  reg [3:0] pin;
  wire qout;

  piso_shift uut(.clk(clk),.reset(reset),.load(load),.pin(pin),.qout(qout));

  initial begin 
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("piso_shift.vcd");
    $dumpvars(0,piso_shift_tb);
  end

  initial begin
    $monitor("TIME=%0t | clk=%b | rst=%b | ld=%b | pin=%b | qout=%b",$time,clk,reset,load,pin,qout);

    reset=1; load=0; pin=4'b0000; #10;
    reset=0; load=1; pin=4'b1011; #10;
    load=0; #50;
    reset=0; load=1; pin=4'b1001; #10;
    load=0; #50;
    $finish;
  end
endmodule

