module cmos_modeling_tb;

  reg d_in, n_ctrl, p_ctrl;
  wire out;

  cmos_modeling uut (
    .d_in(d_in),
    .n_ctrl(n_ctrl),
    .p_ctrl(p_ctrl),
    .out(out));

  initial begin
    $dumpfile("dump.vcd");  
    $dumpvars(0, cmos_modeling_tb);
    $display("Time | d_in n_ctrl p_ctrl | out");
    $display("--------------------------------");
    $monitor("%4t |  %b   %b     %b    | %b", $time, d_in, n_ctrl, p_ctrl, out);
    // Case 00
    d_in = 0; n_ctrl = 0; p_ctrl = 0; #10;
    d_in = 1; #10;

    // Case 01 (OFF → High-Z)
    d_in = 0; n_ctrl = 0; p_ctrl = 1; #10;
    d_in = 1; #10;

    // Case 10 (ON → ideal transmission)
    d_in = 0; n_ctrl = 1; p_ctrl = 0; #10;
    d_in = 1; #10;

    // Case 11
    d_in = 0; n_ctrl = 1; p_ctrl = 1; #10;
    d_in = 1; #10;
    $finish;
  end

endmodule

