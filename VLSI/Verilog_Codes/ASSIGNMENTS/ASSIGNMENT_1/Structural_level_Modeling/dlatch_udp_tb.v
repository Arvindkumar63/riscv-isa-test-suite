module dlatch_udp_tb;
  reg clk,d;
  wire q;

  dlatch_udp uut(q,clk,d);

  initial begin
    $dumpfile("dlatch_udp.vcd");
    $dumpvars(0,dlatch_udp_tb);
    $display("Time | CLK D | Q");
    $display("-----------------");
    $monitor("%4t | %b  %b | %b", $time,clk,d,q);

    clk=0; d=0; #10;   
    clk=1; d=1; #10;   
    clk=0; d=1; #10;   
    clk=1; d=0; #10; 
    clk=0; d=0; #10;   
    clk=1; d=1; #10;   
    clk=0; d=0; #10; 

    $finish;
  end
endmodule

