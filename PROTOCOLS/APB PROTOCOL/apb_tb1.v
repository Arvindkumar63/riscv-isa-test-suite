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

  // APB write 
    task apb_write(input [7:0] addr, input [7:0] data);
    begin
        @(posedge pclk);
        read_write = 1;
        apb_write_paddr = addr;
        apb_write_data = data;
        transfer = 1;

        @(posedge pclk);
        transfer = 0;

        repeat(3) @(posedge pclk);
        $display("---WRITE--- Addr=%0h Data=%0h", addr, data);
    end
    endtask

    // APB read
    task apb_read(input [7:0] addr);
    begin
        @(posedge pclk);
        read_write = 0;
        apb_read_paddr = addr;
        transfer = 1;

        @(posedge pclk);
        transfer = 0;

        repeat(3) @(posedge pclk);
        $display("---READ---  Addr=%0h Data=%0h", addr, prdata);
    end
    endtask

  initial begin
	  pclk = 1'b0;
	  forever #5 pclk = ~pclk;
  end

  // READ AND WRITE using TASK
  initial begin
	  $dumpfile("apb.vcd");
	  $dumpvars(0,apb_tb);

	  prstn = 0;
	  transfer = 0;
	  read_write = 0;
	  apb_write_paddr = 8'd0;
	  apb_read_paddr = 8'd0;
	  apb_write_data = 8'd0;

	  #10;
	  prstn = 1;
	  #10;

	  // Write
          apb_write(8'h05, 32'hAAAA);
     	  apb_write(8'h10, 32'hBBBB);
     	  apb_write(8'h15, 32'hCCCC);

          // Read
          apb_read(8'h05);
          apb_read(8'h10);
          apb_read(8'h15);

        #50 $finish;
  end
endmodule
