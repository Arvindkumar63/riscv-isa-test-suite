module spi_tb;
  reg clk;
  reg rst;
  reg start;
  reg [7:0] master_data;
  reg [7:0] slave_data;
  wire [7:0] master_out;
  wire [7:0] slave_out;
  wire done;
  wire sclk;

  spi_top uut (
    .clk(clk),
    .sclk(sclk),
    .rst(rst),
    .start(start),
    .master_data(master_data),
    .slave_data(slave_data),
    .master_out(master_out),
    .slave_out(slave_out),
    .done(done));

  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  initial begin
    $dumpfile("spi.vcd");
    $dumpvars(0,spi_tb);
    rst = 1;
    start = 0;
    master_data = 8'hA5; 
    slave_data = 8'h23;
    $monitor("TIME = %0t | master_out = %b | slave_out = %b",$time, master_out, slave_out);	
    #50;
    rst = 0;
    #50;
    start = 1;          
    #50;
    start = 0;

     #1000;	
     $display("Master sent: %h", master_data);
     $display("Slave sent:  %h", slave_data);
     $display("Master received: %h", master_out);
     $display("Slave received:  %h", slave_out);
     #10;
     $finish;
  end
endmodule
