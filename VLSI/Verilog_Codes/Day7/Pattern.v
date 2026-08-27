module pattern;
  reg [7:0]num;
  integer i,j;
  
  always @(*) begin
  for (i=1;i<=num;i++) begin
      for(j=1;j<=i;j++) begin
	      $write(i);
      end
      $display("\n");
  end
  for (i=num-1;i>=1;i--) begin
      for(j=i;j>=1;j--) begin
              $write(i);
      end
      $display("\n");
  end
  end

  initial begin 
	  num=3; #10;
	  num=4; #100;
	  $finish;
  end
endmodule



  
