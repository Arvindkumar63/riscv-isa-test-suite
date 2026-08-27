module bidirectional_switch_tb;
  reg in_out1, ctrl;
  wire in_out2, in_out2_if0, in_out2_if1;

  bidirectional_switch uut(
    .in_out1(in_out1),
    .ctrl(ctrl),
    .in_out2(in_out2),
    .in_out2_if0(in_out2_if0),
    .in_out2_if1(in_out2_if1));

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0, bidirectional_switch_tb);
    $display("Time | in_out1 ctrl | tran out | tranif0 out | tranif1 out");
    $display("----------------------------------------------------------");
    $monitor("%4t |    %b      %b   |    %b     |     %b      |     %b", $time, in_out1, ctrl, in_out2, in_out2_if0, in_out2_if1);

    in_out1 = 0; ctrl = 0; #10;
    in_out1 = 1; #10;
    in_out1 = 0; ctrl = 1; #10;
    in_out1 = 1; #10;
    $finish;
  end

endmodule

