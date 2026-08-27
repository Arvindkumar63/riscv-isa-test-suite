module portdeclaration_post2001_tb;
   reg p,q;
   wire y;
   portdeclaration_post2001 uut(y,p,q); //positional association
   initial begin
   $dumpfile("dump.vcd");
   $dumpvars(0, portdeclaration_post2001_tb);
   end
   initial begin
     $monitor("a=%b b=%b y=%b", p, q, y);
     p=0; q=0; #10;
     p=0; q=1; #10;
     p=1; q=0; #10;
     p=1; q=1; #10;
     $finish;
   end 
endmodule
