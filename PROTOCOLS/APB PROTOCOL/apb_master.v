module apb_master(
  input pclk,
  input prstn,
  input transfer,
  input read_write,
  input [7:0]apb_write_paddr,
  input [7:0]apb_write_data,
  input [7:0]apb_read_paddr,
  input [7:0]prdata,
  input pready,
  output reg pwrite,
  output reg psel,
  output reg penable,
  output reg [7:0]paddr,
  output reg [7:0]pwdata,
  output reg [7:0]apb_read_data);

  parameter IDLE = 2'b00, SETUP = 2'b01, ACCESS = 2'b10;
  reg [1:0] state, next_state;

  always @(posedge pclk or negedge prstn) begin
  	if(!prstn)
	    state <= IDLE;
	else
	    state <= next_state;
  end

  always @(*) begin
	  case(state)
	    IDLE: next_state = transfer ? SETUP : IDLE;
	    SETUP: next_state = ACCESS;
	    ACCESS: begin 
	             if(!pready) 
			     next_state = ACCESS;
		     else if(transfer)
			     next_state = SETUP;
		     else
			     next_state = IDLE;
	     end
          endcase
  end

  always @(*) begin
	  psel = (state != IDLE);
	  penable = (state == ACCESS);

	  pwrite = 1'b0;
	  paddr = 8'd0;
	  pwdata = 8'd0;
	  apb_read_data = 8'd0;

	  if ((state == SETUP) || (state == ACCESS)) begin
		  pwrite = read_write;
		  pwdata = read_write ? apb_write_data : 8'd0;
		  paddr = read_write ? apb_write_paddr : apb_read_paddr;
		  apb_read_data = read_write ? 8'd0 : prdata;
	  end
  end

endmodule
