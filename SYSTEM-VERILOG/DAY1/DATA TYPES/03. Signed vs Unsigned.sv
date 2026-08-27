// Signed vs Unsigned
module data_type_3;
  logic signed [3:0] s = -4;
  logic [3:0] u = -4;     // unsigned by default

  initial begin
    $display("signed = %0d", s);
    $display("unsigned = %0d", u);
    #10 $finish;
  end
endmodule
