// Inline conflict with class constraint
class gene;
  rand bit[2:0] value;
  constraint c1 {value >2;}
endclass

module inline_class;
  gene gen;
  int check;
  initial begin
    gen = new();
    for (int i = 0; i <3; i++) begin
      check =  gen.randomize() with {value == 1;} ;
      if(check)
      $display("Iteration : %0d | value = %0d ", i, gen.value);
      else
        $display("Randomization Failed");
    end
  end
endmodule


//OUTPUT
# KERNEL: Randomization Failed
# KERNEL: Randomization Failed
# KERNEL: Randomization Failed
