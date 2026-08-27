module t_ff_async (
  input clk, rst, T,        
  output reg Q,
  output Qb);

  assign Qb = ~Q;

  always @(posedge clk or posedge rst) begin
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

