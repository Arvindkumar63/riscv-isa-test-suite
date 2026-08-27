module sram_controller_simple(
  input clk,rst,start,rw,
  input [7:0] addr_in,
  input [7:0] cpu_data_in,
  output  reg [7:0] cpu_data_out,
  output reg ready,
  output reg [7:0] sram_addr,
  inout [7:0] sram_data,
  output reg sram_ce,
  output reg sram_oe,
  output reg sram_we);

  parameter IDLE = 2'b00;
  parameter READ = 2'b01;
  parameter WRITE = 2'b10;
  parameter DONE = 2'b11;

  reg [1:0] state, next_state;
  reg [7:0]sram_dout;
  reg sram_drive;

  assign sram_data = sram_drive ? sram_dout : 8'bz;

  always @(posedge clk or posedge rst) begin 
    if(rst)
      state <= IDLE;
    else
      state <= next_state;
  end

  always @(*) begin
    case(state)
      IDLE: if(start) begin
              if(rw)
		next_state = WRITE;
              else 
                next_state = READ;
              end
      READ: next_state = DONE;
      WRITE: next_state = DONE;
      DONE: next_state = IDLE;
      default: next_state = IDLE;
      endcase
  end

  always @(posedge clk or posedge rst) begin
	  if(rst) begin
             ready <= 1;
	     sram_ce <= 0;
	     sram_oe <= 0;
	     sram_we <= 0;
	     sram_drive <= 0;
           end
	   else begin
	     case(state)
		     IDLE:  ready <= 1;
		     READ: begin
			     ready <= 0;
                 sram_addr <= addr_in;
			     sram_ce <= 1;
			     sram_oe <= 1;
			     sram_we <= 0;
			     sram_drive <= 0;
		     end
		     WRITE: begin
			      ready <= 0;
			      sram_addr <= addr_in;
			      sram_dout <= cpu_data_in;
			      sram_drive <= 1;
			      sram_ce <= 1;
			      sram_oe <= 0;
			      sram_we <= 1;
		      end
		      DONE: begin
			      ready <= 1;
			      sram_ce <= 0;
			      sram_oe <= 0;
			      sram_we <= 0;
			      sram_drive <= 0;
			      cpu_data_out <= sram_data;
		      end
	      endcase
           end
  end
endmodule


   
