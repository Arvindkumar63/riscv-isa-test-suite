module bitslice(
  input [7:0]data,
  output [3:0]upper,lower,sum);
  

  assign upper = data[7:4];
  assign lower = data[3:0];
  assign sum = upper + lower;

endmodule

