//Design
module clk_gen(
  input clk,
  input rst,
  output reg clk_out);
  reg [19:0] count;

  always @ (posedge clk) begin
    if(rst) begin
      count <= 0;
      clk_out <= 0;
    end
    else if (count < 249999) 
      count <= count + 1;
    else begin
      count <= 0;
      clk_out <= ~clk_out;
    end
  end
endmodule

//Testbench
module clk_tb;
  reg clk;
  reg rst;
  wire clk_out;

  clk_gen uut (.clk(clk), .rst(rst), .clk_out(clk_out));

  always #10 clk=~clk;

  initial begin
	  $dumpfile("clk_out.vcd");
	  $dumpvars;
	  $monitor("CLKOUT=%b",clk_out);
	  clk = 0;
	  rst = 1;
	  #30;
	  rst = 0;
	  #20000000;
	  $finish;
  end
  endmodule
	  

