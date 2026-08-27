module sram #(parameter ADDR_WIDTH = 8, parameter DATA_WIDTH = 16)
             ( input clk, reset,
               input [ADDR_WIDTH - 1 : 0] address,
               input [DATA_WIDTH - 1 : 0] write_data,
               input write_en,
               output reg [DATA_WIDTH - 1:0] read_data);
       //Memory array declaration
       reg [DATA_WIDTH -1 : 0] mem [(1<<ADDR_WIDTH) - 1 : 0];

       //SRAM Operation
       always @(posedge clk or posedge reset) begin
	       if (reset)
		       read_data <= 0;
	       else if(write_en)
		       mem[address] <= write_data;
	       else
		       read_data <= mem[address];
       end
endmodule

//Testbench
module sram_tb;
  parameter ADDR_WIDTH =8;
  parameter DATA_WIDTH = 16;
  reg clk, reset, write_en;
  reg [ADDR_WIDTH - 1 : 0 ] address;
  reg [DATA_WIDTH - 1 : 0 ] write_data;
  wire [DATA_WIDTH - 1 : 0 ] read_data;

 sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) uut ( .clk(clk), .reset(reset), .address(address), 
	 .write_data(write_data), .write_en(write_en), . read_data(read_data));

  always #5 clk = ~clk;

  initial begin
	$dumpfile("sram.vcd");
	$dumpvars;
	$monitor("Time=%0t | Addr=%0d | WE=%b | WD=%h | RD=%h",
                  $time, address, write_en, write_data, read_data);

        clk = 0;
        reset = 1;
        write_en = 0;
        address = 0;
        write_data = 0;

        #15 reset = 0;

        // Write operations
        #10 write_en = 1; address = 4'd0; write_data = 8'hAA;
        #10 address = 4'd1; write_data = 8'hBB;
        #10 address = 4'd2; write_data = 8'hCC;


        // Read operations
	#10 write_en = 0;
        #10 address = 4'd0;
        #10 address = 4'd1;
        #10 address = 4'd2;

        #20 $finish;
    end
      
endmodule

