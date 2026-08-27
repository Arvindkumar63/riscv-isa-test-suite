module muxN #(parameter N=8)(
  input  [N-1:0]a,b,
  input sel,
  output [N-1:0]y
);
  genvar i;
  generate
    for (i=0; i<N; i=i+1) begin : mux_loop
      assign y[i] = sel ? b[i] : a[i];
    end
  endgenerate
endmodule

