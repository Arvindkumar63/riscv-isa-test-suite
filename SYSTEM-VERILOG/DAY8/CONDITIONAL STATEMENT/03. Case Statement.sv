// Case statement
module case_example;
  bit[1:0] sel;
  initial begin
    sel = 2'b10;
    case(sel)
      2'b00: $display("00 is selected");
      2'b01: $display("01 is selected");
      2'b10: $display("10 is selected");
      default: $display("Default is selected");
    endcase
  end
endmodule
