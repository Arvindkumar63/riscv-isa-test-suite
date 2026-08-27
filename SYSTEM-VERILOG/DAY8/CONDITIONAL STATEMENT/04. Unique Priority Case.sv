// Unique Case statement
module unique_case_example;
  bit[1:0] sel;
  initial begin
    sel = 2'b10;
    unique case(sel)
      2'b00: $display("00 is selected");
      2'b01: $display("01 is selected");
      2'b10: $display("10 is selected");
      default: $display("Default is selected");
    endcase
  end
endmodule

// In unique case -> None of case items are matches or there is no ‘Default’ case Warning occur
//In unique case-> More than case items are matches Warning occur
//------------------------------------------------------------



// Unique0 Case statement
module unique0_case_example;
 // bit[1:0] sel;
  initial begin
    sel = 2'b11;
    unique0 case(sel)
      2'b00: $display("00 is selected");
      2'b01: $display("01 is selected");
      2'b10: $display("10 is selected");
    endcase
  end
endmodule

// In unique case -> No run time warning is expected even if there is no case item matches or there is no ‘Default’ case.
//------------------------------------------------------------



//Priority Case Stattement
module priority_case_example;
  bit[1:0] sel;
  initial begin
    sel = 2'b10;
    priority case(sel)
      2'b00: $display("00 is selected");
      2'b01: $display("01 is selected");
      2'b10: $display("10 is selected");
      default: $display("Default is selected");
    endcase
  end
endmodule

//In priority case -> None of cases matches or there is no ‘default’ case warning is expected
// Multiple cases matches , first one only executed
