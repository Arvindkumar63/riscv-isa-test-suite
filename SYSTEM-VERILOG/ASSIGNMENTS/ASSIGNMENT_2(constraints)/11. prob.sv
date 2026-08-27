// Write a constraint where a variable's range of 0-100 has 10% probability and 101-255 has 30% probability.
class cons_11;
  rand bit [7:0] data;
  
  constraint c11{ data dist{[0:100] := 10 , [101:255] := 30};}
endclass

module constraint_11;
  cons_11 c1 = new();
  initial begin
    repeat(8) begin
      c1.randomize();
      $display("data = %0d",c1.data);
    end
  end
endmodule
