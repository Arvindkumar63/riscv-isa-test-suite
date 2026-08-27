module jk_ff_async (
  input clk, rst, J, K,    
  output reg Q,
  output Qb);

  assign Qb = ~Q;

  always @(posedge clk or posedge rst) begin
    if (rst)
      Q <= 0;           
    else begin
      case ({J,K})
        2'b10: Q <= 1;  
        2'b01: Q <= 0;  
        2'b00: Q <= Q;  
        2'b11: Q <= ~Q; 
      endcase
    end
  end
endmodule

