module not_gate_tb;
  reg in;
  wire out;

  not_gate uut(
  .in(in),
  .out(out));

  initial begin
    $dumpfile("dump.vcd");      
    $dumpvars(0, not_gate_tb);

    $display("Time | in | out");
    $display("----------------");
    $monitor("%4t | %b  | %b", $time, in, out);

    in = 0; #10;   
    in = 1; #10;   

    $finish;
  end

endmodule
