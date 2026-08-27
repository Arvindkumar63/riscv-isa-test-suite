module Mux_buf_tb;
  reg i0,i1,sel;
  wire y;

  Mux_buf uut(.i0(i0),.i1(i1),.sel(sel),.y(y));

  initial begin
    $dumpfile("Mux_buf.vcd");
    $dumpvars(0,Mux_buf_tb);  
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

