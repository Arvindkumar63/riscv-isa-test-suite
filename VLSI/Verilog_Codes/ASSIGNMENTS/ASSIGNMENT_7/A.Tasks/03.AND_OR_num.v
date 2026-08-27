module and_or_num;
  reg [7:0]A,B;
  reg [7:0]and_out;
  reg [7:0]or_out;

  task AO_task(input [7:0]A, input [7:0]B, output [7:0]and_out, output [7:0]or_out );
    begin
      and_out=A&B;
      or_out=A|B;
    end
  endtask

  initial begin
    $monitor("Time=%t | A=%b | B=%b | AND=%b | OR=%b" ,$time,A,B,and_out,or_out);
    A=8'd15; B=8'd45;
    AO_task(A,B,and_out,or_out);
    #10;A=8'd13; B=8'd12;
    AO_task(A,B,and_out,or_out);
    #10;A=8'd30; B=8'd30;
    AO_task(A,B,and_out,or_out);
    #10;A=8'd30; B=8'd15;
    AO_task(A,B,and_out,or_out);
    #10;A=8'd35; B=8'd15;
    AO_task(A,B,and_out,or_out);
    #100;
    $finish;
  end
endmodule
