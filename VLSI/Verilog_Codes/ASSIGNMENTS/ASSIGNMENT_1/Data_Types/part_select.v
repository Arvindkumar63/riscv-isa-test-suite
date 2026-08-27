module part_select;
  reg [7:0]bus;
  reg [3:0]bits;
  
  initial begin
    $monitor("TIME = %t, Selected_Bits = %b", $time, bits);
    bus=8'b10101100;
    bits=bus[3:0]; #10;
    bits=bus[7:4];

  end

endmodule
