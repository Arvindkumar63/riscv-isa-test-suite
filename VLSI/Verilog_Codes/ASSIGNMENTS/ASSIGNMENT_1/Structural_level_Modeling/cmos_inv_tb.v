module cmos_inv_tb;
  reg in;
  wire out;

  cmos_inv uut(
  .in(in),
  .out(out));

  initial begin
    $dumpfile("cmos_inv.vcd");      
    $dumpvars(0, cmos_inv_tb);

    $display("Time | in | out");
    $display("----------------");
    $monitor("%4t | %b  | %b", $time, in, out);

    in = 0; #10;   
    in = 1; #10;   

    $finish;
  end

endmodule
