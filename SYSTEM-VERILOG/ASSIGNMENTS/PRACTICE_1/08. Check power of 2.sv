//Design
// Check the 8 bit input is power of 2

module power_of_two(
  input logic[7:0] data,
  output logic out);
  assign out = (data!=0) && ((data & data-1) == 0);
endmodule

// Testbench
module tb;
  logic [7:0]data;
  logic out;
  
  power_of_two pow(data, out);
  
  initial begin
    $monitor("data= %0d | out= %0b " ,data, out);
    for(int i = 0; i <20; i++) begin
      data = i;
      #10;
    end
  end
endmodule
