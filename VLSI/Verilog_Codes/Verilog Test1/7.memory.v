module memory_8to14;
  reg [13:0] mem[7:0];
  reg [20:0] sum;
  reg [13:0] max;
  integer i;

  task fill; 
	  begin
	    for (i=0; i<8; i++)
		mem[i] = i*2;
	  end
  endtask

  task add;
	  begin
          sum = 0;
	    for (i=0; i<8; i++)
		 sum = sum + mem[i];
	  end
  endtask

  task max_val;
	  begin
	  max = mem[0];
	    for (i=1; i<8; i++) begin
	       if(max < mem[i])
		       max = mem[i];
	       else 
		       max = max;
            end
         end
  endtask

  initial begin
	  fill();
	  for (i=0; i<8; i++)
		  $display("mem[%0d] = %0d ",i, mem[i]);

	  add();
	  max_val();
	  $display("SUM=%0d MAX=%0d", sum,max);
	  #100 $finish;
  end
  endmodule
