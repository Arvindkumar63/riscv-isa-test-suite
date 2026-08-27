module t_ff_sync (
  input clk, rst, T,        
  output reg Q,
  output Qb);

  assign Qb = ~Q;

  always @(posedge clk) begin
    if (rst)
      Q <= 0;           
    else begin
      if (T)
        Q <= ~Q;        
      else
        Q <= Q;         
    end
  end
endmodule

