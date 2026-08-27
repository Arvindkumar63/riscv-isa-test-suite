module logic_udp_tb;
  reg x,y,z;
  wire f;

  logic_udp uut(f,x,y,z);

  initial begin
    $dumpfile("logic_udp.vcd");
    $dumpvars(0,logic_udp_tb);
    $display("Time | x y z | f");
    $display("-----------------");
    $monitor("%4t | %b %b %b | %b", $time, x, y, z, f);

    x=0; y=0; z=0; #10;
    x=0; y=0; z=1; #10;
    x=0; y=1; z=0; #10;
    x=0; y=1; z=1; #10;
    x=1; y=0; z=0; #10;
    x=1; y=0; z=1; #10;
    x=1; y=1; z=0; #10;
    x=1; y=1; z=1; #10;
  $finish;
  end
endmodule

