// Only Inline Constraint
class gene;
  rand bit[2:0] value;
endclass

module only_inline;
  gene gen;
  initial begin
    gen = new();
    for (int i = 0; i <5; i++) begin
      gen.randomize() with {value<4;} ;
      $display("Iteration : %0d | value = %0d ", i, gen.value);
    end
  end
endmodule

//OUTPUT
Iteration : 0 | value = 1 
Iteration : 1 | value = 2 
Iteration : 2 | value = 3 
Iteration : 3 | value = 0 
Iteration : 4 | value = 3
