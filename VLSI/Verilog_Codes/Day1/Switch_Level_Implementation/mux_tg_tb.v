module mux_tg_tb;
  reg i0, i1, s;
  wire y;
  
  mux_tg uut(
  .i0(i0),
  .i1(i1),
  .s(s),
  .y(y));

  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(0, mux_tg_tb);
    $display("Time | I0 I1 S | y");
    $display("----------------");
    $monitor("%4t | %b %b %b | %b", $time, i0, i1, s, y);

    i0=1; i1=0; s=0; #10; 
    i0=0; i1=1; s=0; #10; 
    i0=1; i1=0; s=1; #10; 
    i0=0; i1=1; s=1; #10;  
    $finish;
  end

endmodule
