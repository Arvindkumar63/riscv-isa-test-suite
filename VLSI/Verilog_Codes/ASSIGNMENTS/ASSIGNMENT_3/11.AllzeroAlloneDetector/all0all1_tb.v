module all0all1_tb;
  reg [7:0]data;
  wire zero,one;

  all0all1 uut(.data(data),.zero(zero),.one(one));

  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(0,all0all1_tb);
    $monitor (" Time = %t | DATA = %b | ZERO = %b | ONE = %b ",$time,data,zero,one);
    data = 8'b00100001; #10;
    data = 8'b00000000; #10;
    data = 8'b11010010; #10;
    data = 8'b11111111; #10;
    data = 8'b11011000; #10;
    $finish;
  end 
endmodule
