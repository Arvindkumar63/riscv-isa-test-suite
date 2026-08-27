`timescale 1ns/1ps
`default_nettype none
module sync_fifo_tb;
localparam WIDTH = 8, DEPTH = 8;
reg clk=0, srst_n=0, wr_en=0, rd_en=0;
reg [WIDTH-1:0]data_in;
wire full, empty;
wire [WIDTH-1:0]data_out;
integer pass=0, fail=0;
integer i;

sync_fifo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) uut (.clk(clk), .srst_n(srst_n), .wr_en(wr_en), .rd_en(rd_en), .data_in(data_in), .data_out(data_out), .full(full), .empty(empty));

  always #5 clk = ~clk;

  task push( input integer a); begin
	  @(posedge clk);
	  wr_en=1; data_in=a;
	  if(full) begin
		  $display("Attempted push is Ignored");
	  end
	  else begin 
	  $display("PUSH:%0d ",a);
          end
  end
  endtask

  task pop(input integer exp); begin
	  @(posedge clk);
	  if (empty) begin
          $display("Attempted pop is ignored");
          end
	  else begin
	  rd_en=1;
	  #1;
           if (data_out!==exp[7:0]) begin
	    $display("[FAIL] pop exp=%0d got=%0d",exp,data_out); fail++;
           end
           else begin $display("[PASS] pop=%0d",data_out); pass++;
            end
         end
  end
  endtask
  initial begin
    $dumpfile("dump.vcd"); $dumpvars( );
    srst_n=0;
    #10;
    srst_n=1;
    for (i=0;i<DEPTH;i=i+1) push(i+10);
    #10;
    for (i=0;i<DEPTH;i=i+1) pop(i+10);
    $display("[REPORT] total=%0d pass=%0d fail=%0d",pass+fail,pass,fail);
 $finish;
  end
endmodule
