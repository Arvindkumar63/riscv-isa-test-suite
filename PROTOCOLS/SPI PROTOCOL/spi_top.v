module spi_top (
  input clk,
  input rst,
  input start,
  input [7:0] master_data,
  input [7:0] slave_data,
  inout sclk,
  output [7:0] master_out,
  output [7:0] slave_out,
  output done);

  wire ss;
  wire mosi;
  wire miso;

  spi_master master_inst(
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(master_data),
    .received_data(master_out),
    .sclk(sclk),
    .mosi(mosi),
    .miso(miso),
    .ss(ss), 
    .done(done) );

  spi_slave slave_inst(
    .clk(clk),
    .start(start),
    .rst(rst),
    .sclk(sclk),
    .mosi(mosi),
    .ss(ss),
    .miso(miso),
    .data_in(slave_data),
    .received_data(slave_out),
    .done(done) );

endmodule

