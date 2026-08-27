module equality;
  reg [7:0]A;
  reg [7:0]B;
  reg flag;

  task Equa_flag(input [7:0]A,input[7:0]B, output flag);
    begin
  if(A==B)
    flag=1;
  else
    flag=0;
  end
  endtask

  initial begin
  $monitor("Time=%t  |  A=%b  | B=%b | Flag=%b" ,$time,A,B,flag);
  A=8'd10;B=8'd10;
  Equa_flag(A,B,flag);#10
  A=8'd244;B=8'd244;
  Equa_flag(A,B,flag);#10
  A=8'd200;B=8'd100;
  Equa_flag(A,B,flag);#10
  A=8'd23;B=8'd24;
  Equa_flag(A,B,flag);#10
  #100;
  $finish;
  end
endmodule
