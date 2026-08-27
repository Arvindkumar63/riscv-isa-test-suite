module compare2bit_tb;
  reg  [1:0] a, b;
  wire Eq, Less, Greater;

  compare2bit uut (
  .a(a),  
  .b(b), 
  .eq(Eq), 
  .lt(Less), 
  .gt(Greater));

  initial begin
    $dumpfile("comp_wave.vcd");
    $dumpvars(0, compare2bit_tb);
    $display("Time | A   B | Equal Lesser Greater");
    $display("-----------------------------------");
    $monitor("%4t | %b %b |  %b      %b        %b", $time, a, b, Eq, Less, Greater);

    a=2'b00; b=2'b00; #10;
    a=2'b00; b=2'b01; #10;
    a=2'b00; b=2'b10; #10;
    a=2'b00; b=2'b11; #10;
    a=2'b01; b=2'b00; #10;
    a=2'b01; b=2'b01; #10;                                                                            
    a=2'b01; b=2'b10; #10;
    a=2'b01; b=2'b11; #10;                                                                            
    a=2'b10; b=2'b00; #10; 
    a=2'b10; b=2'b01; #10;
    a=2'b10; b=2'b10; #10;
    a=2'b10; b=2'b11; #10;
    a=2'b11; b=2'b00; #10;                                                                            
    a=2'b11; b=2'b01; #10;
    a=2'b11; b=2'b10; #10;
    a=2'b11; b=2'b11; #10;
    $finish;
  end
endmodule

