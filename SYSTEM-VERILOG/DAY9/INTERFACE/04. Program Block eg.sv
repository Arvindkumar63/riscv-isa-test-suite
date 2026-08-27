// Program Block example
//Design 
module design_ex(output bit [7:0] addr);
  initial begin
    addr <= 10;
  end
endmodule

program testbench(input bit [7:0] addr); // If it is module addr = 0 bcoz of active region execution of display
  // Bcoz of program block, it is executed in reactive region after NBA in design execution... Expected output addr = 10;
  initial begin
    $display("Addr = %0d" , addr);
  end
endprogram

// Program Block example
// Testbench 
module tb_top;
  wire [7:0] addr;
  design_ex dut (addr);
  testbench test (addr);
endmodule
