//Interface
interface fifo_intf #(parameter Width = 8); 
  logic wclk;
  logic rclk;
  logic wrst_n;
  logic rrst_n;
  logic r_en;
  logic w_en;
  logic [Width-1:0] data_in;
  logic [Width-1:0] data_out;
  logic full;
  logic empty;
endinterface
