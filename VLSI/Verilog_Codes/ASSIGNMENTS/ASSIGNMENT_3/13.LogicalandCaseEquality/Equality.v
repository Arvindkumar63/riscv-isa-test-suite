module equality(
  input [3:0]a,b,
  output y_case,y_logic);
  
  assign y_case = (a===b);    //looking for exact match
  assign y_logic= (a==b);     //if any bit is x or z, output is x
endmodule
