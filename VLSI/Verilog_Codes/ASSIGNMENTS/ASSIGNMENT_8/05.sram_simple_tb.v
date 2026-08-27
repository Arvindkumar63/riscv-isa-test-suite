module sram_model (
  inout [7:0] data,
  input [7:0] addr,
  input ce,    
  input oe,    
  input we );

  reg [7:0] mem [0:7];
  reg [7:0] data_reg;
  reg drive_data;

  assign data = drive_data ? data_reg : 8'bz;

  always @(*) begin
    drive_data = 0;  
    if (ce) begin
      if (we) begin
        mem[addr] = data;       
      end 
      else if (oe) begin
        data_reg   = mem[addr]; 
        drive_data = 1;
      end
    end
  end
endmodule


module sram_controller_tb;

  reg clk,rst,start,rw;
  reg [7:0] addr_in;
  reg [7:0] cpu_data_in;
  wire [7:0] cpu_data_out;
  wire ready;
  wire [7:0] sram_addr;
  wire [7:0] sram_data;
  wire sram_ce;
  wire sram_oe;
  wire sram_we;

  sram_controller_simple dut( .clk(clk), .rst(rst), .start(start), .rw(rw), .addr_in(addr_in), .cpu_data_in(cpu_data_in),
    .cpu_data_out(cpu_data_out), .ready(ready), .sram_addr(sram_addr), .sram_data(sram_data), .sram_ce(sram_ce), .sram_oe(sram_oe), .sram_we(sram_we) );

  sram_model sram ( .data(sram_data), .addr(sram_addr), .ce(sram_ce), .oe(sram_oe), .we(sram_we));

  always #5 clk = ~clk;

  initial begin
  $monitor("Time=%0t | state=%0d | addr=%h | cpu_in=%h | cpu_out=%h | ce=%b oe=%b we=%b",
           $time, dut.state, addr_in, cpu_data_in, cpu_data_out, sram_ce, sram_oe, sram_we);
  end

  initial begin
    $dumpfile("sram_controller.vcd");
    $dumpvars(0, sram_controller_tb);


    clk = 0; rst = 1; start = 0; rw = 0;
    addr_in = 0; cpu_data_in = 0;
    #20 rst = 0;

    @(posedge clk);
    addr_in = 8'h05;
    cpu_data_in = 8'hAA;
    rw = 1; start = 1;
    @(posedge clk);
    start = 0;

    #20;

    @(posedge clk);
    addr_in = 8'h05;
    rw = 0; start = 1;
    @(posedge clk);
    start = 0;

    #50 $finish;
  end

endmodule
                        
