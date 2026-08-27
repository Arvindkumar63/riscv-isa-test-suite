module square_num;
  reg [7:0]in;
  reg [15:0]out;

  task square(input [7:0]A, output [15:0]Out);
    begin
      Out=A**2;
    end
  endtask

  initial begin
    $monitor("Time=%t | IN=%b(%d) | Square of %d = %b(%d)",$time,in,in,in,out,out);
    in=8'd12;
    square(in,out);
    #10;in=8'd25;
    square(in,out);
    #10;in=8'd5;
    square(in,out);
    #10;in=8'd50;
    square(in,out);
    #10;in=8'd165;
    square(in,out);
    #10;in=8'd85;
    square(in,out);
    #10;in=8'd15;
    square(in,out);
    #10;in=8'd20;
    square(in,out);
    #100
    $finish;
  end 
endmodule
