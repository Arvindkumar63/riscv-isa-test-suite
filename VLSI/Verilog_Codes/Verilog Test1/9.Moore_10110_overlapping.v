module moore_10110(
  input clk, rst, in,
  output out);

  parameter S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4, S5=3'd5;
  reg [2:0] state, next_state;

  always @(posedge clk or posedge rst) begin
    if(rst)
      state <= S0;
    else
      state <= next_state;
  end

  always @(*) begin
    case(state)
	S0: next_state = in ? S1:S0;
	S1: next_state = in ? S1:S2;
	S2: next_state = in ? S3:S0;
	S3: next_state = in ? S4:S2;
	S4: next_state = in ? S1:S5;
	S5: next_state = in ? S3:S0;
	default: next_state = S0;
    endcase
  end

  assign out = (state == S5);
endmodule

//Testbench
module moore_tb;
  reg clk, rst, in;
  wire out;

  moore_10110 uut (.clk(clk), .rst(rst), .in(in), .out(out));

  always #5 clk = ~clk;

  initial begin
	  $monitor("TIME=%0t | clk=%b | rst=%b | in=%b | out=%b" ,$time,clk,rst,in,out);
	  clk = 0;
	  in = 0;
	  rst = 1;
	  #15;
	  rst = 0;
	  #10;

	  //Test case
	  in = 1; #10;
	  in = 0; #10;
	  in = 1; #10;
	  in = 1; #10;
	  in = 0; #10;
	  in = 1; #10;
	  in = 1; #10;
	  in = 0; #10;
	  in = 1; #10;
	  in = 1; #10;
	  #10 $finish;
  end
endmodule
