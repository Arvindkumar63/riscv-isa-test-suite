module apb_tb;
  reg pclk;
  reg prstn;
  reg transfer;
  reg read_write;
  reg [7:0] apb_write_paddr;
  reg [7:0] apb_read_paddr;
  reg [7:0] apb_write_data;
  wire pready;
  wire [7:0] prdata;

  apb_top uut(
    .pclk(pclk),
    .prstn(prstn),
    .transfer(transfer),
    .read_write(read_write),
    .apb_write_paddr(apb_write_paddr),
    .apb_read_paddr(apb_read_paddr),
    .apb_write_data(apb_write_data),
    .pready(pready),
    .prdata(prdata));

  initial begin
	  pclk = 1'b0;
	  forever #5 pclk = ~pclk;
  end
 
  //SIMPLE READ AND WRITE OPERATIONS
  initial begin
	  $dumpfile("apb.vcd");
	  $dumpvars(0,apb_tb);

	  prstn = 0;
	  transfer = 0;
	  read_write = 0;
	  apb_write_paddr = 8'd0;
	  apb_read_paddr = 8'd0;
	  apb_write_data = 8'd0;

	  #15;
	  prstn = 1;
	  
	  #10;
	  // write 
	  transfer = 1;
	  read_write = 1;
	  apb_write_paddr = 8'h11;
	  apb_write_data = 8'hA5;

	  #20;
	  transfer = 0;

	  #20;
	  //read
	  transfer = 1;
	  read_write = 0;
	  apb_read_paddr = 8'h11;

	  #20;
	  transfer = 0;

	  #30 $finish;
  end
endmodule
