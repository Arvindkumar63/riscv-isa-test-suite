// Overriding Constraint
class parent_class;
  rand byte a;
  rand byte b;
  constraint cons{a==0;b==5;}
endclass

class child_class extends parent_class;
  constraint cons{a==5;b==8;}
endclass


module tb;
  initial begin
    child_class c1 = new();
  for(int i=0;i<3;i++)
  begin
    if (!c1.randomize()) begin
      $display("Iteration = %0d :Randomization failed",i);
    end
    else 
      $display("Iteration = %0d value of the a=%0d value of b=%0d",i,c1.a,c1.b);
end
end
endmodule   


//OUTPUT
Iteration = 0 value of the a=5 value of b=8
Iteration = 1 value of the a=5 value of b=8
Iteration = 2 value of the a=5 value of b=8
