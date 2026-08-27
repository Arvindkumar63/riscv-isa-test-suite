`default_nettype none
module sync_fifo #(parameter WIDTH = 8, DEPTH = 8) (input wire clk, srst_n, wr_en, rd_en,
	input wire [WIDTH-1:0]data_in, output reg [WIDTH-1:0]data_out, output wire empty,full); 
 
  localparam AW = $clog2(DEPTH);
  reg [WIDTH-1:0] mem [0:DEPTH-1];
  reg [AW-1:0]rptr,wptr;

  always @(posedge clk) begin
	  if(!srst_n) begin
		  rptr <= 0;
		  wptr <= 0;
		  data_out <= 0;
	  end
  end
  always @(posedge clk) begin
	  if(wr_en && !full) begin
		 mem[wptr] <= data_in;
		 wptr <= wptr + 1'b1;
	 end
 end
 always @(posedge clk) begin
	 if(rd_en && !empty) begin
		 data_out <= mem[rptr];
        	 rptr <= rptr + 1'b1;
	 end
  end

  assign full = (wptr+1'b1 == rptr) ? 1'b1 : 1'b0;
  assign empty = (wptr == rptr) ? 1'b1 : 1'b0;
endmodule
