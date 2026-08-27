module glob_var;
  reg [3:0]A,B;
  reg [4:0]glob_var;

  task glob_task;
    input [3:0]x,y;
    begin
    glob_var=x+y;
    end
  endtask

  initial begin
    $monitor("Time=%t | A=%d | B=%d | Glob_var(sum)=%d",$time, A,B,glob_var);
    A=4'd9;B=4'd12; glob_task(A,B);#10
    A=4'd10;B=4'd13; glob_task(A,B);#10
    A=4'd11;B=4'd14; glob_task(A,B);#10
    A=4'd12;B=4'd8; glob_task(A,B);#10
    #100
    $finish;
  end 
endmodule
