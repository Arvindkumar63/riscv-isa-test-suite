//SPI MASTER MODULE
module spi_master(
  input clk, rst, start, miso,
  input [7:0] data_in,
  output reg sclk, ss, mosi, done,
  output reg [7:0] received_data);

  reg [3:0] bit_cnt;

  parameter IDLE = 2'b00, LOAD = 2'b01, TRANSFER = 2'b10, DONE = 2'b11;
  reg [1:0] state,next_state;

  always @(posedge clk or posedge rst) begin
    if (rst)
	state <= IDLE;
    else
	state <= next_state;
  end

  always @(*) begin
        case(state)
            IDLE: next_state = start ? LOAD : IDLE;
	    LOAD: next_state = TRANSFER;
            TRANSFER: next_state = (bit_cnt == 0 ) ? DONE : TRANSFER;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
  end

  always @ (posedge clk or posedge rst) begin
    if (rst) begin
	  ss <= 1'b1;
	sclk <= 1'b0;
	done <= 1'b0;
	mosi <= 1'b0;
	bit_cnt <= 4'd8;
	received_data <= data_in;
    end
    else begin
        case(state)
	  IDLE: begin
		ss <= 1'b1; 
		sclk <= 1'b0;
		done <= 1'b0;
         	end
	  LOAD: begin
		ss <= 1'b0;
		bit_cnt <= 4'd8;
		received_data <= data_in;
	        end
      TRANSFER: begin
	        sclk <= ~sclk;   //Toggles at every clk(freq of sclk = freq of clk/2)
		  if(sclk==1'b1) begin
                  // Sample data from slave (MISO) at rising edge
                    received_data <= {received_data[6:0], miso};
                  end
		  else begin
                  // Shift data out to MOSI at falling edge
		    mosi <= received_data[7];
                    if (bit_cnt != 0)
                        bit_cnt <= bit_cnt - 1;
                    else
                        bit_cnt <= 0;
                 end
	        end
	    
	  DONE: begin
                ss <= 1'b1;
                sclk <= 1'b0;
                done <= 1'b1;
                end
        endcase
     end
   end
endmodule
