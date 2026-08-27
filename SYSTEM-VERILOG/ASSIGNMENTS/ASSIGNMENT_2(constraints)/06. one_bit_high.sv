// Write a constraint to generate a 32-bit number where exactly one bit is high.
class cons_6;
  rand bit[31:0] data;
  
  constraint c6{ $countones(data) == 1 ;}
endclass
module constraint_6;
  cons_6 c1 = new();
  initial begin
    repeat(10) begin
      c1.randomize();
      $display("data = %0b",c1.data);
    end
  end
endmodule
