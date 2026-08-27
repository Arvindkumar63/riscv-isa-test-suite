// Write a constraint to generate a sequence where even numbers appear in odd positions.
class cons_8;
  rand bit[15:0] data[10];
  
  constraint c8{ foreach(data[i]) 
    if(i%2 == 1)
      data[i]%2 == 0;}
endclass
module constraint_8;
  cons_8 c1 = new();
  initial begin
    repeat(5) begin
      c1.randomize();
      foreach(c1.data[i]) begin
        $display("data[%0d] = %0d",i,c1.data[i]);
      end
    end
  end
endmodule
