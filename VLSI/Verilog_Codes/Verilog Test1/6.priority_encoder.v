module priority_encoder(
  input [7:0] d,
  output reg [2:0]y);

  always @(*) begin
    casez(d)
       8'b1??????? : y = 3'd7;
       8'b01?????? : y = 3'd6;
       8'b001????? : y = 3'd5;
       8'b0001???? : y = 3'd4;
       8'b00001??? : y = 3'd3;
       8'b000001?? : y = 3'd2;
       8'b0000001? : y = 3'd1;
       8'b00000001 : y = 3'd0;
       default     : y = 3'dx;
      endcase
     end
endmodule 

//Testbench
module priority_tb;
  reg [7:0]d;
  wire [2:0]y;

  priority_encoder uut(.d(d), .y(y));

  initial begin
	  $monitor("TIME=%0t | D=%b | Y=%b" ,$time,d,y);
	  d = 8'b10111011; #10;
	  d = 8'b01110000; #10;
	  d = 8'b00010000; #10;
	  d = 8'b00001110; #10;
	  #10 $finish;
  end
endmodule
