module block_nonblock;
  reg a1,a2,b1,b2;

  initial begin
  a1 = 1;
  a2 = a1;
  end
 
  initial begin 
  b1 <= 0;
  b2 <= b1;
  end 

  initial begin
  #10;
  $display("BLOCKING: a1 = %b | a2 = %b",a1,a2);
  $display("NON BLOCKING: b1 = %b | b2 = %b",b1,b2);
  end
endmodule
