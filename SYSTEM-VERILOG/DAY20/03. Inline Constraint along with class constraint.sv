//  Inline Constraint along with class constraint
class gene;
  rand bit[2:0] value;
  constraint c1 {value >2;}
endclass

module inline_class;
  gene gen;
  initial begin
    gen = new();
    for (int i = 0; i <5; i++) begin
      gen.randomize() with {value<5;} ;
      $display("Iteration : %0d | value = %0d ", i, gen.value);
    end
  end
endmodule

//OUTPUT
Iteration : 0 | value = 3 
Iteration : 1 | value = 4 
Iteration : 2 | value = 3 
Iteration : 3 | value = 4 
Iteration : 4 | value = 3 
