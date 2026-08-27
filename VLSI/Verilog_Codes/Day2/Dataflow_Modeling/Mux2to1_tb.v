module Mux2to1_tb;
  reg i0,i1,sel;
  wire y_cond,y_bitwise;

  Mux2to1 uut(.i0(i0),.i1(i1),.sel(sel),.y_cond(y_cond),.y_bitwise(y_bitwise));

  initial begin
    $dumpfile("Mux2to1.vcd");
    $dumpvars(0,Mux2to1_tb);  
    $monitor("TIME=%0t | i0=%b i1=%b sel=%b | y_conditonal=%b y_bitwise=%b",$time,i0,i1,sel,y_cond,y_bitwise);

    i0=0; i1=0; sel=0; #10;
    i0=1; i1=0; sel=0; #10;
    i0=0; i1=1; sel=0; #10;
    i0=1; i1=1; sel=0; #10;

    i0=0; i1=0; sel=1; #10;
    i0=1; i1=0; sel=1; #10;
    i0=0; i1=1; sel=1; #10;
    i0=1; i1=1; sel=1; #10;

    $finish;
    end
endmodule

