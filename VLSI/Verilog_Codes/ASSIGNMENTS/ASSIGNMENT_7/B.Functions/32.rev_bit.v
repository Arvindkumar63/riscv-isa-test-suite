module rev_bit_func;
  reg [7:0]in;
  wire [7:0]out;

  function [7:0]rev_bit(input [7:0]in);
    integer i;
    begin
    for(i=0;i<=7;i++)
    rev_bit[7-i]=in[i];
    end 
  endfunction
  assign out = rev_bit(in);

  initial begin 
    $monitor("Time=%t | IN=%b | OUT=%b",$time,in,out);
    in=8'b01011011; #10;
    in=8'b00001111; #10;
    in=8'b00000011; #10;
    in=8'b01111011; #10;
    in=8'b01000011; #10;
    in=8'b00101011;
    #100;
    $finish;
    end 
endmodule
