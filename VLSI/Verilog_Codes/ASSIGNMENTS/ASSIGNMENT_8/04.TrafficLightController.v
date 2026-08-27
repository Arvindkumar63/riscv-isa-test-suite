module traffic_light(
  input clk, rst, Emg_A, Emg_B, SA, SB,
  output reg RA, YA, GA, RB, YB, GB);       //RA,YA,GA->light indication for North to South and South to North
                                            //RB,YB,GB->light indication for East to West and West to East   

  parameter s0 = 4'd0;
  parameter s1 = 4'd1;
  parameter s2 = 4'd2;
  parameter s3 = 4'd3;
  parameter s4 = 4'd4;
  parameter s5 = 4'd5;
  parameter s6 = 4'd6;
  parameter s7 = 4'd7;
  parameter s8 = 4'd8;
  parameter s9 = 4'd9;
  parameter s10 = 4'd10;
  parameter s11 = 4'd11;
  parameter s12 = 4'd12;

  reg [3:0] state, next_state;

  always @(posedge clk or posedge rst) begin
	 if(rst)
	    state <= s0;
         else if(Emg_A)
	    state <= s12;
         else if(Emg_B)
            state <= s6;
         else
            state <= next_state;
  end

  always @ (*) begin
         case(state)
		  s0, s1, s2, s3, s4, s6, s7, s8, s9, s10: next_state = state +1;
		  s5: if (SA&&(~SB)) next_state = s5;
		      else next_state = s6;
		  s11: if (SB&&(~SA)) next_state = s11;
	               else next_state = s12;
		  s12: next_state = s0;
         endcase
 end

 always @(*) begin 
	 RA = 1'b0;
	 YA = 1'b0;
	 GA = 1'b0;

	 RB = 1'b0;
	 YB = 1'b0;
	 GB = 1'b0;

	 case(state)
		 s0,s1,s2,s3,s4,s5: begin
			 GA = 1'b1;
			 RB = 1'b1;
		 end
		 s6: begin
			 YA = 1'b1;
			 RB = 1'b1;
		 end
		 s7,s8,s9,s10,s11: begin
			 RA = 1'b1;
			 GB = 1'b1;
		 end
		 s12: begin
			 RA = 1'b1;
			 YB = 1'b1;
		 end
	 endcase
 end
 endmodule 
