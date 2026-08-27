module sum_num;
  reg [7:0]A,B;
  wire [8:0]Sum;
 
  function [8:0] add(input [7:0]A,input [7:0]B);
  begin
   add=A+B;
  end
  endfunction
  assign Sum=add(A,B);
  
  initial begin
    $monitor("Time=%t | A=%b(%d) | B=%b(%d) | Sum=%b(%d)",$time,A,A,B,B,Sum,Sum);
    A=8'd10;B=8'd15; #10;
    A=8'd20;B=8'd15; #10;
    A=8'd05;B=8'd30; #10;
    A=8'd24;B=8'd12; #10;
    #100;
    $finish;
  end
endmodule
