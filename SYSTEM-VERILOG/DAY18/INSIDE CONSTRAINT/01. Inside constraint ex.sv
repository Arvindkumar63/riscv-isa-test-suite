// Inside constraint
class class_0;
  rand bit [3:0] a;
  rand bit [3:0] b;
  constraint c1 { a inside{[3:9]};}
  constraint c2 { b inside{2,3,4,5};}
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
 Iteration: 0  -------------> a = 6  | b = 5 
 Iteration: 1  -------------> a = 6  | b = 2 
 Iteration: 2  -------------> a = 9  | b = 2 
 Iteration: 3  -------------> a = 4  | b = 3 
 Iteration: 4  -------------> a = 5  | b = 4 
 Iteration: 5  -------------> a = 6  | b = 4 
 Iteration: 6  -------------> a = 3  | b = 4 
 Iteration: 7  -------------> a = 5  | b = 5 
 Iteration: 8  -------------> a = 5  | b = 3 
 Iteration: 9  -------------> a = 3  | b = 3 
