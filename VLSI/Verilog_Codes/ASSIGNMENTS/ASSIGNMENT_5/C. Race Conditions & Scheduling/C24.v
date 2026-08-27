module exchange;
  reg clk;
  reg q1, q2;  //For Blocking
  reg q3, q4; //For Non-Blocking

  initial begin
    clk=0; q1=0; q2=1; q3=1; q4=0;
    forever #5 clk = ~clk;
  end

  // Blocking assignment: race!
  always @(posedge clk) begin
    q1 = q2;
    q2 = q1;
  end
  
  // Non-Blocking assignment: race free
  always @(posedge clk) begin
    q3 <= q4;                                                                                                                                                   q4 <= q3;
  end   

  initial begin
    $monitor("Time=%2t | clk = %b |Blocking: q1=%b q2=%b |Non-Blocking: q3=%b q4=%b",$time,clk,q1,q2,q3,q4);
    #50 $finish;
  end
endmodule

