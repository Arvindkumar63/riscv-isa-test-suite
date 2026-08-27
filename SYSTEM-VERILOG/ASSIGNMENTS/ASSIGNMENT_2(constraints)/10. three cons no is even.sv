// Write a constraint to ensure that the sum of three consecutive numbers is even.
class cons_10;
  rand bit[15:0] data[20];
  
  constraint c10{ foreach(data[i]) (data[i]+data[i+1]+data[i+2])%2 == 0; 
                 unique{data};}
endclass
module constraint_10;
  cons_10 c1 = new();
  initial begin
    c1.randomize();
    foreach(c1.data[j]) begin
      $display("data[%0d] = %0d",j,c1.data[j]);
    end
  end
endmodule
