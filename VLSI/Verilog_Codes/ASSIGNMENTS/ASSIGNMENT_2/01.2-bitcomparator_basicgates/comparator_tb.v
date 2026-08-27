module comparator_tb;
  reg  [1:0] a, b;
  wire Eq, Less, Greater;

  comparator uut (
  .a(a),  
  .b(b), 
  .Eq(Eq), 
  .Less(Less), 
  .Greater(Greater));

  initial begin
    $dumpfile("comp_wave.vcd");
    $dumpvars(0, comparator_tb);
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

