//Write a constraint to generate specific values: 25, 27, 30, 36, 40, 45.
class gen_spec;
  rand bit[5:0] data;
  
  constraint c3{ data inside {25, 27, 30, 36, 40, 45};}
  
endclass

module constraint_3;
  gen_spec gen;
    initial begin
      gen = new();
      repeat(10) begin
        gen.randomize();
        $display("%0d", gen.data);
      end
      $finish;
    end
endmodule
