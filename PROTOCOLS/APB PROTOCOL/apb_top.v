module apb_top(
  input pclk,
  input prstn,
  input transfer,
  input read_write,
  input [7:0] apb_write_paddr,
  input [7:0] apb_read_paddr,
  input [7:0] apb_write_data,
  output pready,
  output [7:0] prdata
); 

  wire pwrite,psel,penable;
  wire [7:0] paddr,pwdata,apb_read_data;

  apb_master master_inst( 
   .pclk(pclk),
   .prstn(prstn),
   .transfer(transfer),
   .read_write(read_write),
   .apb_write_paddr(apb_write_paddr),
   .apb_write_data(apb_write_data),
   .apb_read_paddr(apb_read_paddr),
   .prdata(prdata),
   .pready(pready),
   .pwrite(pwrite),
   .psel(psel),
   .penable(penable),
   .paddr(paddr),
   .pwdata(pwdata),
   .apb_read_data(apb_read_data));

  apb_slave slave_inst(
   .pclk(pclk),
   .prstn(prstn),
   .pwrite(pwrite),
   .psel(psel),
   .penable(penable),
   .paddr(paddr),
   .pwdata(pwdata),
   .pready(pready),
   .prdata(prdata));

endmodule
