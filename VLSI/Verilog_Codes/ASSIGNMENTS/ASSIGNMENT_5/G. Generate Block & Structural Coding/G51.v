module reg_array_generate(
  output reg [7:0]a);
  genvar i;

  generate
    for (i = 0; i < 8; i = i + 1) begin 
      initial a[i] = 1'b0;
    end
  endgenerate
endmodule

