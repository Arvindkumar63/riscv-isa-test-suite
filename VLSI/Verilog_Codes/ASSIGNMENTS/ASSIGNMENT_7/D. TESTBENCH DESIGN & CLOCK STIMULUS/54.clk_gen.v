module clk_gen;
  reg clk;
  
  initial clk=0;
  always #5 clk = ~clk;

  initial begin 
     $monitor ("TIME=%0t | clk=%b",$time,clk);
     #100;
     $finish;
  end
endmodule
