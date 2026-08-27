module shift (
  input [3:0]in,
  output [3:0] out1,out2);
  assign out1 = (in<<1); //left shift
  assign out2 = (in>>1);  //right shift
endmodule
