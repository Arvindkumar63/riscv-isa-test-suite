// Write a constraint for a 16-bit variable such that no two consecutive 1's are generated.
class cons_5;
  rand bit[15:0] data;
  
  constraint c5{foreach(data[i]) 
    if(i<15) !(data[i]&&data[i+1]) ;}
endclass
module constraint_5;
  cons_5 c1 = new();
  initial begin
    repeat(10) begin
      c1.randomize();
      $display("data = %0b",c1.data);
    end
  end
endmodule
