module dlatch_high_tb;
  reg d,en;
  wire q,qbar;
  dlatch_high uut (.d(d),.en(en),.q(q),.qbar(qbar));
  initial begin
    $monitor ("TIME=%0t | D=%b | En=%b | Q=%b | Qbar=%b",$time,d,en,q,qbar);
    $dumpfile("dlatch_high.vcd");
    $dumpvars;
    
   #10; en=1; d=1;
   #10;       d=0;
   #10; en=0; d=1;
   #10;       d=0;
   #10;
   $finish;
  end 
endmodule
