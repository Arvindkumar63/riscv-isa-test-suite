module mux4to1 (
  input [3:0] d,
  input [1:0] s,
  output reg y);

  always @(*) begin
    if (s[1])
      if (s[0])
         y = d[3];
      else
         y = d[2];
    else 
      if (s[0])
         y = d[1];
      else
         y = d[0];
  end
endmodule

