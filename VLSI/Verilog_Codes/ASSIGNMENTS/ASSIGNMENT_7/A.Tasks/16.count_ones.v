module count_ones;
  reg [7:0]data;
  reg [3:0]count;

  task count_one(input [7:0]A,output [3:0]out);
   integer i;
   begin
    out=0;
    for(i=0;i<8;i++) begin
     if(A[i]==1)
      out=out+1;
    end
   end
  endtask
  
  initial begin
   $monitor("Time=%t  | data=%b | count=%d",$time,data,count);
   data=8'd30;
   count_one(data,count);
   #10 data=8'd35;
   count_one(data,count);
   #10 data=8'd40;
   count_one(data,count);
   #10 data=8'd45;
   count_one(data,count);
   #10 data=8'd32;
   count_one(data,count);
   #10 data=8'd25;
   count_one(data,count);
   #100;
   $finish;
  end 
endmodule
