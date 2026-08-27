module part_select1;
  reg [7:0]bus;
  reg [3:0]busA;
  integer i;

  initial begin
    $monitor("TIME = %t, BUS = %b, BUS_A = %b",$time, bus, busA);
    bus=8'b11001100; 
    for (i=0; i<4; i++) 
    begin
      busA[i] = bus[i];
    end
    #10;

    bus=8'b11001111;
    busA = bus[3:0];
    #10;
    $finish;
  end

endmodule
