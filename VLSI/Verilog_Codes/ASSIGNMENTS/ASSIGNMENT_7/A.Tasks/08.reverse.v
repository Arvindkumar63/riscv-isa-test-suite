module rev_bit;
  reg [7:0]in;
  reg [7:0]rev_in;

  task task_rev(input [7:0]in,output [7:0]rev_in);
  integer i;
    begin
      for(i=0;i<8;i++)
        rev_in[7-i]=in[i];
    end 
  endtask

  always @(*)
    task_rev(in,rev_in);

  initial begin
  $monitor("Time=%t | in=%b  | Reversed=%b", $time, in,rev_in);
  in=8'd15; #10;
  in=8'd25; #10;
  in=8'd200; #10;
  in=8'd108; #10;
  in=8'd247;                                                                                                                                                  #100; $finish;
  end
endmodule

