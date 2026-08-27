module dualport_ram(
  input [7:0]data_a, data_b,
  input we_a, we_b,
  input [7:0]address_a, address_b,
  input clk,
  output reg [7:0] data_outa, data_outb);

  reg [7:0] mem [255:0];

  always @(posedge clk) begin
    if(we_a) 
      mem[address_a] <= data_a;
    else
      data_outa <= mem[address_a];
  end

  always @(posedge clk) begin
    if(we_b)
      mem[address_b] <= data_b;
    else
      data_outb <= mem[address_b];
  end
endmodule

module dualport_ramtb;
  reg [7:0] data_a, data_b;
  reg we_a, we_b;
  reg [7:0] address_a, address_b;
  reg clk;
  wire [7:0] data_outa, data_outb;

  dualport_ram uut(.data_a(data_a), .data_b(data_b), .we_a(we_a), .we_b(we_b), .address_a(address_a), 
	  .address_b(address_b), .clk(clk), .data_outa(data_outa), .data_outb(data_outb));

  always #5 clk = ~ clk;

  initial begin
	  clk = 0;
	  $dumpfile("dualport.vcd");
	  $dumpvars;

	  #5;

	  we_a = 1;
	  we_b = 1;

	  data_a = 8'hAA;
	  data_b = 8'hBB;

	  address_a = 8'd10;
	  address_b = 8'd11;

	  #10;

	  we_a = 0;

	  address_a = 8'd11;
	  address_b = 8'd12;

	  data_b = 8'hCC;

	  #10;

	  we_b = 0;

	  address_a = 8'd12;
	  address_b = 8'd10;

	  #10 $finish;
  end
  endmodule
