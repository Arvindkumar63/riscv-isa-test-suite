module switch_modeling_tb;
  reg data,ctrl;
  wire p_out,n_out;

  switch_modeling uut(.data(data),.ctrl(ctrl),.p_out(p_out),.n_out(n_out));

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0,switch_modeling_tb);
    $display("Time | data ctrl | p_out n_out");
    $display("-----------------------------");
    $monitor("%4t  | %b   %b   | %b    %b   ",$time,data,ctrl,p_out,n_out);

    data = 0; ctrl = 0; #10;
    data = 1; ctrl = 0; #10;
    data = 0; ctrl = 1; #10;
    data = 1; ctrl = 1; #10;
    // unknown control
    data = 1; ctrl = 1'bx; #10;
    // high impedance control
    data = 0; ctrl = 1'bz; #10;
    $finish;
  end
endmodule

