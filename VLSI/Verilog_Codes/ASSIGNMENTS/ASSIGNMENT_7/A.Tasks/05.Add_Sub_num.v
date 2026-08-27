module add_sub_num;
  reg [7:0]A,B;
  reg [8:0]add_out;
  reg  signed [8:0]sub_out;

  task AS_task(input [7:0]A, input [7:0]B, output [8:0]add_out, output [8:0]sub_out );
    begin
      add_out=A+B;
      sub_out=A-B;
    end
  endtask
  
  always @(*)
     AS_task(A,B,add_out,sub_out);
  
  initial begin
    $monitor("Time=%t | A=%b(%d) | B=%b(%d) | ADD=%b(%d) | SUB=%b(%d)" ,$time,A,A,B,B,add_out,add_out,sub_out,sub_out);
    A=8'd15; B=8'd45;
    #10;A=8'd13; B=8'd12;
    #10;A=8'd30; B=8'd30;
    #10;A=8'd30; B=8'd15;
    #10;A=8'd35; B=8'd15;
    #100;
    $finish;
  end
endmodule
