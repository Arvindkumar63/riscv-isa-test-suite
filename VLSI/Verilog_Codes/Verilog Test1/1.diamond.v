module diamond;
  integer num,i,j;

  initial begin
     num = 5;
     for(i=1; i<=num; i++) begin
	 for(j=1; j<=num-i; j++) 
	    $write("\t");
         for(j=1; j<=i; j++)
	    $write("%d\t",i);
     $display("\n");
     end

     for(i=num-1; i>=1; i--) begin
	 for(j=1; j<=num-i; j++) 
             $write("\t");
         for(j=1; j<=i; j++)
            $write("%d\t",i);
     $display("\n");
     end
  end
endmodule
