// Write a constraint to avoid generating the same 4-variable value as any of the last 5 occurrences.
class cons_7;
  rand bit[3:0] data;
  bit [3:0] last[5];
  
  constraint c7{ foreach(last[i]) (data != last[i]);}
endclass
module constraint_7;
  cons_7 c1 = new();
  initial begin
    repeat(10) begin
      c1.randomize();
      $display("data = %0b",c1.data);
      for (int i = 4; i>0; i--) begin
        c1.last[i] = c1.last[i-1];
      end
      c1.last[0] = c1.data;
    end
  end
endmodule
