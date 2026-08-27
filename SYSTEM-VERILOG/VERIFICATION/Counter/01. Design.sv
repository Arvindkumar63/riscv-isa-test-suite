// Design 
module counter(
  input logic clk,
  input logic rst,
  input logic u_d, // 1-> up_count 0-> down_count
  output logic [3:0]count);
  
  always_ff @ (posedge clk or posedge rst) begin
    if(rst)
      count <= '0;
    else if(u_d)
      count <= count+1;
    else 
      count <= count-1;
  end
endmodule
