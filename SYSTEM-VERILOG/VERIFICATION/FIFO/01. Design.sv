// Design 
module sync_fifo #(parameter Width = 8, Depth = 8)
  (input logic clk, rst, wr_en, rd_en,
   input logic [Width-1:0] d_in,
   output logic [Width-1:0] d_out,
   output logic full, empty);
  
  localparam ptr_width = $clog2(Depth);
  
  logic [Width-1 : 0] fifo[Depth];
  logic [ptr_width-1:0] wr_ptr, rd_ptr;
  
  always_ff @(posedge clk) begin
    if(rst) begin
      d_out <= '0;
      wr_ptr <= 0;
      rd_ptr <= 0;
      
    end
    else if(wr_en && !full) begin
      fifo[wr_ptr] <= d_in;
      wr_ptr <= wr_ptr+1;
    end
    else if(rd_en && !empty) begin
      d_out <= fifo[rd_ptr];
      rd_ptr <= rd_ptr+1;
    end
  end
  
  assign full = ((wr_ptr+1) == rd_ptr)? 1'b1 : 1'b0;
  assign empty = (wr_ptr == rd_ptr) ? 1'b1 : 1'b0;
endmodule
    
