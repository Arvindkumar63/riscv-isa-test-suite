// Task with premature return
module task_eg;
  int a,b;
  bit[7:0] out;
  task result (input int a,b, output bit[7:0] out);
    if(a==b) begin
      out = a+b;
      return ;// cannot return any value in task // premature return
      $display("A+B"); // It doesn't display bcoz of previous return
    end
    else if(a<b) begin
      out = b-a;
      $display("B-A");
      return ;
    end
    else begin
      out = a-b;
      $display("A-B");
      return;
    end
  endtask
  
  initial begin
    a=10; b=10;
    result(a,b,out);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
    a=11; b=40;
    result(a,b,out);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
    a=20; b=9;
    result(a,b,out);
    $display("a=%0d | b=%0d | out = %0d",a,b,out);
  end
  
endmodule
