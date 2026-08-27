module apb_slave(
  input pclk,
  input prstn,
  input pwrite,
  input psel,
  input penable,
  input [7:0] paddr,
  input [7:0] pwdata,
  output reg pready,
  output reg [7:0] prdata 
 ); 

 reg [7:0] mem [255:0];

 always @ (posedge pclk or negedge prstn) begin
	 if(!prstn) begin
		 pready <= 1'b0;
		 prdata <= 8'b0;
	 end
	 else begin
		 if(penable) begin
			 pready <=1'b1;
			 if (pwrite)
				 mem[paddr] = pwdata;
			 else
				 prdata = mem[paddr];
		 end
		 else
			 pready <= 1'b0;
	 end
 end

endmodule
