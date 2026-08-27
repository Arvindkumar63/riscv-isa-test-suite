module no_of_1;
  reg [3:0]vec;
  integer i,ones;

  always @(vec) begin
    i=0; ones=0;

  while (i<4)  begin
    if (vec[i]) 
      ones = ones+1;
    i=i+1;
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
    
