module clk_gen;
  reg clk;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;   // forever loop inside initial
  end
  initial begin 
     $monitor("%2t   %b",$time,clk);
     #100;
     $finish;
  end
 
endmodule

