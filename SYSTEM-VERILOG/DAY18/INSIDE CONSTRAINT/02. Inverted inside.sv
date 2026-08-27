// Inverted Inside constraint
class class_0;
  rand bit [3:0] a;
  rand bit [3:0] b;
  constraint c1 { !(a inside{[3:9]});}
  constraint c2 { !(b inside{2,3,4,5});}
endclass

module top;
  initial begin
    class_0 c = new();
    for (int i=0; i<10; i++) begin
      void'(c.randomize());
      $display(" Iteration: %0d  -------------> a = %0d  | b = %0d ",i,c.a,c.b);
    end
  end
endmodule

//OUTPUT
 Iteration: 0  -------------> a = 12  | b = 11 
 Iteration: 1  -------------> a = 11  | b = 8 
 Iteration: 2  -------------> a = 15  | b = 12 
 Iteration: 3  -------------> a = 10  | b = 13 
 Iteration: 4  -------------> a = 15  | b = 10 
 Iteration: 5  -------------> a = 12  | b = 14 
 Iteration: 6  -------------> a = 12  | b = 14 
 Iteration: 7  -------------> a = 0  | b = 15 
 Iteration: 8  -------------> a = 11  | b = 1 
 Iteration: 9  -------------> a = 10  | b = 1 
