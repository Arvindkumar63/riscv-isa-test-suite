//Mux
module mux2to1(
  input s,i0,i1,
  output y);
  assign y = s ? i1 : i0;
endmodule

//Gates using MUX
module gates(
  input a,b,
  output and_y,or_y,nand_y,nor_y,xor_y,xnor_y);
  
  wire nb;
  not n1(nb, b);

  mux2to1 m1(.s(a), .i0(1'b0), .i1(b), .y(and_y));
  mux2to1 m2(.s(a), .i0(b), .i1(1'b1), .y(or_y));
  mux2to1 m3(.s(a), .i0(1'b1), .i1(nb), .y(nand_y));
  mux2to1 m4(.s(a), .i0(nb), .i1(1'b0), .y(nor_y));
  mux2to1 m5(.s(a), .i0(b), .i1(nb), .y(xor_y));
  mux2to1 m6(.s(a), .i0(nb), .i1(b), .y(xnor_y));
endmodule
