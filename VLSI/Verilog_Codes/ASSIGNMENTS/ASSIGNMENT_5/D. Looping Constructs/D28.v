module no_of_1_f0rloop;
  reg [3:0]vec;
  integer i,ones;

  always @(vec) begin
  ones=0;
  for (i=0;i<4;i++)  begin
    if (vec[i])
      ones = ones+1;
  end
  end


  initial begin
  #50 $monitor ("TIME = %2t | vec = %b | ones = %0d",$time,vec,ones);
      vec = 4'b1011;
  #50 vec = 4'b1111;
  #50 vec = 4'b0011;
  #50 $finish;
  end

endmodule
