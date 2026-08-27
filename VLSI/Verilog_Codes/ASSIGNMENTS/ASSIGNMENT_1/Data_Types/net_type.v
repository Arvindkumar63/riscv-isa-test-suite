module net_type;

  wand w1;
  wor w2;
  tri w3;
  triand w4;
  reg a,b;

  assign w1 = a;
  assign w1 = b;
  assign w2 = a;
  assign w2 = b;
  assign w3 = a;
  assign w3 = b;
  assign w4 = a;
  assign w4 =b;

  initial begin
    $monitor(" Time = %0t, a = %b, b = %b, wand = %b, wor = %b, tri = %b, triand = %b", $time,a,b,w1,w2,w3,w4); 
    a=1'b0; b=1'b0; #10;
    a=1'b0; b=1'b1; #10;
    a=1'b1; b=1'b0; #10;
    a=1'b1; b=1'b1; #10;
    a=1'b0; b=1'bz; #10;
    a=1'b1; b=1'bz; #10;
    a=1'bz; b=1'b0; #10;
    a=1'bz; b=1'b1; #10;
    $finish;
  end

endmodule
