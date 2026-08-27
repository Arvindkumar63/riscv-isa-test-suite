module priority_select (
  input a, b, c,
  output reg y);
  always @(*) begin
    if (a)
      y = 1'b1;
    else if (b)
      y = 1'b0;
    else if (c)
      y = 1'b1;
    else
      y = 1'b0;
  end
endmodule

