module mux2to1_tb;
  reg i0,i1,sel;
  wire y;

  mux2to1 uut(.i0(i0),.i1(i1),.sel(sel),.y(y));

  initial begin
    $dumpfile("Mux2to1.vcd");
    $dumpvars(0,mux2to1_tb);  
    $monitor("TIME=%0t | i0=%b i1=%b sel=%b | y=%b",$time,i0,i1,sel,y);

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

