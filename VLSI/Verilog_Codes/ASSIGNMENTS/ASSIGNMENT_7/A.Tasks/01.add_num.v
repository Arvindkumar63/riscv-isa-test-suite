module sum_num;
  reg [7:0]A,B;
  reg [8:0]Sum;

  task sum_task(input [7:0]A,input [7:0]B, output [8:0]out);
    begin
      out=A+B;
    end 
  endtask

  initial begin
    $monitor("Time=%t | A=%b(%d) | B=%b(%d)| Sum=%b(%d)" ,$time,A,A,B,B,Sum,Sum);
    A=8'd15; B=8'd15;
    sum_task(A,B,Sum);
    #10;A=8'd13; B=8'd12;
    sum_task(A,B,Sum);
    #10;A=8'd30; B=8'd30;
    sum_task(A,B,Sum);
    #10;A=8'd30; B=8'd45;
    sum_task(A,B,Sum);
    #10;A=8'd20; B=8'd80;
    sum_task(A,B,Sum);
    #100;
    $finish;
  end 
endmodule
