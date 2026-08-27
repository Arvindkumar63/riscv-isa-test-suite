module trailing_zeros;
  reg [7:0] in;
  wire [3:0] count;

  function integer count_trailing_zeros;
    input [7:0] x;
    integer i;
    begin :outer_block
      count_trailing_zeros = 0;
      for (i=0; i<8; i=i+1) begin 
        if (x[i] == 1'b0)
          count_trailing_zeros = count_trailing_zeros + 1;
        else
          disable outer_block;  
      end
    end
  endfunction

  assign count = count_trailing_zeros(in);

  initial begin
    $monitor("TIME=%0t | in=%b | trailing_zeros=%d",$time,in,count);
    in=8'b00001000; #10;
    in=8'b00100110; #10;
    in=8'b00000001; #10;
    in=8'b11100000; #10;
    $finish;
  end
endmodule

