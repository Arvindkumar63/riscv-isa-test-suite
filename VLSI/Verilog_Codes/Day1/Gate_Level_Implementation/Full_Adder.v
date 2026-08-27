module Full_Adder(
  output s,c_out,
  input a, b, c);
  wire g, x, y, z;

  xor(g, a, b);
  xor(s, g, c);
  and(x, a, b);
  and(y, b, c);       
  and(z, c, a);        
  or(c_out, x, y, z);
 
endmodule
    
   
   
  
