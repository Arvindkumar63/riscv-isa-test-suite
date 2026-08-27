module average;
  reg [7:0]A[3:0];
  real avg;

  task calc_average(input [7:0]A3,A2,A1,A0,output real avg);
  integer sum;
  integer i;
  begin
    sum=0;
    for(i=0;i<4;i++)
      sum=sum+A[i];
    avg=sum/4.0;
  end
  endtask

  initial begin
  A[0]=13;
  A[1]=46;
  A[2]=32;
  A[3]=42; #10;
  calc_average(A[3],A[2],A[1],A[0],avg);
  $display("Time=%t | A0=%d | A1=%d | A2=%d | A3=%d | AVERAGE=%f" ,$time,A[0],A[1],A[2],A[3],avg);
  end
endmodule
