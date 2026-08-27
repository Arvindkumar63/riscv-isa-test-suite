// Random function system
module rand_fun;  
integer a;  
integer d;  
logic [2:0] b;  
bit [5:0] e;  
byte c;   

initial begin  
    
  a = $random();   //Returns a 32-bit signed random variable
  b = $urandom();  // Returns a 32-bit unsigned random value
  c = $urandom_range(4,2);  // Returns the value within the range
  d = $random(23); //Uses a seed value to generate a reproducible random number 
  e = $urandom(4); //Uses a seed value for unsigned random number generation
 
  $display("Random Value of a  =  %0d", a);
  $display("Random Value of b = %0d", b);   
  $display("Random value of c = %0d", c);
  $display("Random value of d = %0d", d );
  $display("Random value of e = %0d", e);

  
  $display("\n");
  a = $random();   //Returns a 32-bit signed random variable
  b = $urandom();  // Returns a 32-bit unsigned random value
  c = $urandom_range(4,2);  // Returns the value within the range
  d = $random(23); //Uses a seed value to generate a reproducible random number 
  e = $urandom(4); //Uses a seed value for unsigned random number generation
 
  $display("Random Value of a  =  %0d", a);
  $display("Random Value of b = %0d", b);   
  $display("Random value of c = %0d", c);
  $display("Random value of d = %0d", d );
  $display("Random value of e = %0d", e);

end  

endmodule 


//OUTPUT
# Random Value of a  =  303379748
# Random Value of b = 3
# Random value of c = 4
# Random value of d = -2145894912
# Random value of e = 4
# 
# 
# Random Value of a  =  200518935
# Random Value of b = 1
# Random value of c = 4
# Random value of d = -2145894912
# Random value of e = 4
