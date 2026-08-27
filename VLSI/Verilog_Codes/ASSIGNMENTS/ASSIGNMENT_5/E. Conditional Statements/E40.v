module flag_logic (
  input f1, f2, f3,
  output reg out);
  always @(*) begin
    if (f1 & f2)
      out = 1;
    else if (f2 & f3)
      out = 0;
    else if (f1 & f3)
      out = 1;
    else
      out = 1'bx;
  end
endmodule

