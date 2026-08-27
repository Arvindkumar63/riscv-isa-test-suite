// Write a constraint to generate unique multiples of 3.
class cons_9;
  rand bit[15:0] data[5];
  
  constraint c9{ foreach(data[i]) data[i]%3 == 0;
                 unique{data}; }
endclass
module constraint_9;
  cons_9 c1 = new();
  initial begin
    c1.randomize();
    foreach(c1.data[i]) begin
      $display("data[%0d] = %0d",i,c1.data[i]);
    end
  end
endmodule
