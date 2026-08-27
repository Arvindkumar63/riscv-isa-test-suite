module right_shift;
  reg [7:0] in;
  reg [2:0] n;
  wire [7:0] out;

  function [7:0] right_shift;
    input [7:0] x;
    input [2:0] s;
    begin
      right_shift = x >> s;
    end
  endfunction

  assign out = right_shift(in, n);

  initial begin
    $monitor("TIME=%0t | in=%b | n=%d | out=%b",$time,in,n,out);
    in=8'b10101010; n=3'd1; #10;
    in=8'b11110000; n=3'd2; #10;
    in=8'b10000000; n=3'd7; #10;
    $finish;
  end
endmodule

